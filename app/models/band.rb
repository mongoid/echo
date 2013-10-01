# encoding: utf-8
class Band
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String
  field :formed_on, type: Date
  field :location, type: String
  field :genres, type: Array, default: []
  field :name, type: String
  field :similarities, type: Array, default: []
  field :sounds, type: Array, default: []
  field :website, type: String

  has_many :accesses, validate: false
  has_many :followings, validate: false
  has_many :members, class_name: "User", validate: false, inverse_of: :band

  embeds_many :albums, validate: false
  embeds_many :photos, as: :photographic, validate: false
  embeds_many :tours, validate: false

  # Band names are required in order to have a valid band, and their names must
  # be unique. Description is not required but should be filled out.
  validates :name, presence: true, uniqueness: true

  index({ genres: 1 }, { background: true })
  index({ name: 1 }, { background: true, unique: true })
  index({ "albums.producer_id" => 1 }, { background: true })
  index({ "tours.shows.venue" => "2d" }, { background: true })

  # Get all the bands that have been reviewed by the provided user.
  #
  # @example Get the bands reviewed by a user.
  #   Band.reviewed_by(user)
  #
  # @param [ User ] user The reviewer.
  #
  # @return [ Array<Band> ] The reviewed bands.
  scope :reviewed_by, ->(user) {
    where("albums.reviews.reviewer_id" => user.id)
  }

  # After a new band is created, an entity entry must be created in order to be
  # able to search for the band using a fast search across multiple
  # collections.
  #
  # @example Execute the after create.
  #   observer.after_create(band)
  #
  # @param [ Band ] band The band that was just created.
  def after_create(band)
    Metadata.create(tags: band.searchables, document: band)
  end

  # When we update a band, we should update the entity corresponding to it.
  #
  # @example Update the entity.
  #   observer.after_update(band)
  #
  # @param [ Band ] band The band that was just updated.
  def after_update(band)
    Metadata.where(document_id: band.id).update(tags: band.searchables)
  end

  # Get all the producers for this band, by traversing all the albums they have
  # released.
  #
  # @example Get all the producers.
  #   band.producers
  #
  # @return [ Array<User> ] All the band's producers.
  def producers
    albums.map(&:producer)
  end

  # Get all reviews of all albums for this band.
  #
  # @example Get all the band's reviews.
  #   band.reviews
  #
  # @return [ Array<Review> ] The band's reviews.
  def reviews
    albums.map(&:reviews).flatten
  end

  # Get all album reviews for this band by a specific user.
  #
  # @example Get all the reviews by the provided user.
  #   band.reviews_by(user)
  #
  # @param [ User ] user The reviewer.
  #
  # @return [ Array<Review> ] The reviews.
  def reviews_by(user)
    reviews.select { |review| review.reviewer == user }
  end

  # Gets an array of all the things we can search for this band using. This
  # includes the band's genres, name, producers, similarities and sounds.
  #
  # @example Get the searchable fields.
  #   band.searchables
  #
  # @return [ Array<String> ] The searchable fields.
  def searchables
    genres + [ name ] + producers.map(&:name) + similarities + sounds
  end

  class << self

    # Find the first band with the provided name.
    #
    # @example Find the first band with the name.
    #   Band.named("Sex Pistols")
    #
    # @param [ String ] name The band name.
    #
    # @return [ Band ] The matching band.
    def named(value)
      where(name: value).first
    end
  end
end
