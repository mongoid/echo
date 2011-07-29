# encoding: utf-8
class Track
  include Mongoid::Document
  include Mongoid::Timestamps

  field :disc, type: Integer
  field :downloads, type: Integer, default: 0
  field :length, type: String
  field :name, type: String
  field :notes, type: String
  field :number, type: Integer
  field :streams, type: Integer, default: 0

  embedded_in :album

  # Fields that are required in order to have a valid track.
  validates :disc, :length, :name, :number, presence: true

  # If we want to get the band for this track just delegate up through the
  # album.
  delegate :band, to: :album

  # Send this track to a user requesting to download it. Will update the number
  # of downloads and create an access document for use in recording payments to
  # artists.
  #
  # @example Send the track to the user.
  #   track.send_to(user)
  #
  # @param [ User ] user The user downloading the track.
  #
  # @return [ Access ] The access document.
  def send_to(user)
    Access.downloaded(self, user).tap do
      update_attribute(:downloads, downloads + 1)
    end
  end

  # Stream this track to a user requesting to download it. Will update the
  # number of streams and create an access document for use in recording
  # payments to artists.
  #
  # @example Stream the track to the user.
  #   track.stream_to(user)
  #
  # @param [ User ] user The user streaming the track.
  #
  # @return [ Access ] The access document.
  def stream_to(user)
    Access.streamed(self, user).tap do
      update_attribute(:streams, streams + 1)
    end
  end
end
