# encoding: utf-8
class FollowingObserver < Mongoid::Observer

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
end
