# encoding: utf-8
class Following
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :band, index: true
  belongs_to :user, index: true

  class << self

    # Gets the top 10 bands in the application by the number of followers they
    # have.
    #
    # @example Get the top 10 bands.
    #   Following.ranked
    #
    # @return [ Array<Hash> ] A grouping by count and band id.
    def ranked
    end
  end
end
