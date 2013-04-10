# encoding: utf-8
class Following
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :band, index: true
  belongs_to :user, index: true

  validates :user, presence: true

  # After the creation of a following, if the user has opted to notify Facebook
  # or Twitter we'll access the appropriate service.
  #
  # @example Execute the after create callback.
  #   observer.after_create(following)
  #
  # @param [ Following ] following The following.
  def after_create(following)
    Facebook.post_to_wall(following)
    Twitter.tweet(following)
  end

  class << self

    RANK_MAP = %Q{
      function() {
        emit(this.band_id, { followers: 1 });
      }
    }

    RANK_REDUCE = %Q{
      function(key, values) {
        var result = { followers: 0 };
        values.forEach(function(value) {
          result.followers += value.followers;
        });
        return result;
      }
    }

    # Gets the top 10 bands in the application by the number of followers they
    # have.
    #
    # @example Get the top 10 bands.
    #   Following.ranked
    #
    # @return [ Array<Hash> ] A grouping by count and band id.
    def ranked
      map_reduce(RANK_MAP, RANK_REDUCE).out(inline: 1)
    end
  end
end
