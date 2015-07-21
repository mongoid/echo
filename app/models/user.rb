# encoding: utf-8
class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :first_name, type: String
  field :handle, type: String
  field :last_name, type: String

  belongs_to :band, inverse_of: :members
  has_many :followings, validate: false
  has_one :cat, class_name: "Pet", autosave: true

  embeds_one :role, validate: false
  embeds_one :settings, class_name: "Settings", validate: false

  # User logins are all based on email so it must be present and unique in
  # order to be persisted.
  validates :email, presence: true, uniqueness: true

  # All users must have a role in order for the permissions to be effective.
  validates :role, presence: true

  index({ email: 1 }, { background: true })
  index({ "role.name" => 1 }, { background: true })
  index({ "role.role_id" => 1 }, { background: true })

  # Convenience methods for determining if the user itself is of a specific
  # role in the application.
  #
  # @example Is the user an admin?
  #   user.administrator?
  #
  # @example Is the user an artist?
  #   user.artist?
  #
  # @example Is the user a producer?
  #   user.producer?
  #
  # @example Is the user a subscriber?
  #   user.subscriber?
  #
  # @example Is the user a visitor?
  #   user.visitor?
  #
  # @return [ true, false ] If the user is of the expected type.
  delegate \
    :administrator?,
    :artist?,
    :producer?,
    :subscriber?,
    :visitor?, to: :role

  Reference::Role::TYPES.each do |name|

    # Get all the users for the application for this role.
    #
    # @example Get the administrators.
    #   User.administrators
    #
    # @example Get the artists.
    #   User.artists
    #
    # @example Get the producers.
    #   User.producers
    #
    # @example Get the subscribers.
    #   User.subscribers
    #
    # @return [ Array<User> ] The matching users.
    scope "#{name}s", ->{ where("role.name" => name.to_s) }
  end

  # Does the user have the ability to perform the supplied action?
  #
  # @example Can the user act?
  #   user.able_to?("manage.users")
  #
  # @param [ String ] action The action to check.
  #
  # @return [ true, false ] If the user can act.
  def able_to?(action)
    role.able_to?(action, self)
  end

  # Gets the name of this user. If a handle was provided it uses that,
  # otherwise returns the first and last names.
  #
  # @example Get the user's name.
  #   user.name
  #
  # @return [ String ] The user name.
  def name
    self.handle ||= "#{first_name} #{last_name}".strip
  end

  # Gets all the albums that have been produced by this user.
  #
  # @example Get all the produced albums.
  #   user.productions
  #
  # @return [ Array<Album> ] The albums produced by the user.
  def productions
    Band.where("albums.producer_id" => id).collect do |band|
      band.albums.produced_by(self)
    end.flatten
  end

  # Follow the provided band.
  #
  # @example Follow the band.
  #   user.follow(band)
  #
  # @param [ Band ] band The band to follow.
  #
  # @return [ Band ] The band.
  def follow(band)
    followings.create(band: band)
  end

  # Get all the reviews that this user has authored for all bands.
  #
  # @example Get all the reviews.
  #   user.reviews
  #
  # @return [ Array<Review> ] The user's reviews.
  def reviews
    Band.only("albums.reviews").reviewed_by(self).reduce([]) do |reviews, band|
      reviews.tap do |revs|
        revs.concat(band.reviews_by(self))
      end
    end
  end

  # Unfollow the provided band.
  #
  # @example Unfollow the band.
  #   user.unfollow(band)
  #
  # @param [ Band ] band The band to unfollow.
  def unfollow(band)
    followings.where(band_id: band.id).delete
  end

  class << self

    # Creates a user that is a subscriber to the application.
    #
    # @example Subscribe to the app.
    #   User.subscribe("syd.vicious@pistols.net")
    #
    # @param [ String ] email The user's email.
    #
    # @return [ true, false ] If the subscription succeeded.
    def subscribe(email)
      User.new(email: email) do |user|
        user.role = Reference::Role.subscriber.denormalized
      end.save
    end
  end
end
