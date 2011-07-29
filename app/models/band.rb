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
  has_many :members, class_name: "User", validate: false

  embeds_many :albums, validate: false
  embeds_many :photos, as: :photographic, validate: false
  embeds_many :tours, validate: false

  # Band names are required in order to have a valid band, and their names must
  # be unique. Description is not required but should be filled out.
  validates :name, presence: true, uniqueness: true

  index "albums.producer_id", background: true
  index "genres", background: true
  index "name", background: true, unique: true
  index [[ "tours.shows.venue", Mongo::GEO2D ]], background: true

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
