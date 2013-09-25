# encoding: utf-8
class Access
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  CATEGORIES = [ :download, :stream ]

  field :album_id, type: BSON::ObjectId
  field :category, type: Symbol
  field :track_id, type: BSON::ObjectId

  belongs_to :band
  belongs_to :user

  # All fields on the access model need to be present in order to be able to
  # calculate payments via the DMCA and EUCD model.
  validates :album_id, :band, :category, :track_id, :user, presence: true

  # Is this access document a download?
  #
  # @example Is the access a download?
  #   access.download?
  #
  # @return [ true, false ] Whether the access is a download.
  def download?
    category == :download
  end

  # Is this access document a stream?
  #
  # @example Is the access a stream?
  #   access.stream?
  #
  # @return [ true, false ] Whether the access is a stream.
  def stream?
    category == :stream
  end

  class << self

    # Create an access for a track that has been downloaded by a specific user.
    #
    # @example Create a download.
    #   Access.downloaded(track, user)
    #
    # @param [ Track ] track The track being downloaded.
    # @param [ User ] user The user downloading the track.
    #
    # @return [ Access ] The access document.
    def downloaded(track, user)
      recorded(:download, track, user)
    end

    # Record an access to a track given the user and category of access.
    #
    # @example Record the access.
    #   Access.recorded(download, track, user)
    #
    # @param [ Symbol ] category The type of access.
    # @param [ Track ] track The track being accessed.
    # @param [ User ] user The user accessing the track.
    #
    # @return [ Access ] The access document.
    def recorded(category, track, user)
      create(
        album_id: track.album.id,
        category: category,
        band: track.band,
        track_id: track.id,
        user: user
      )
    end

    # Create an access for a track that has been streamed by a specific user.
    #
    # @example Create a stream.
    #   Access.streamed(track, user)
    #
    # @param [ Track ] track The track being streamed.
    # @param [ User ] user The user streaming the track.
    #
    # @return [ Access ] The access document.
    def streamed(track, user)
      recorded(:stream, track, user)
    end
  end
end
