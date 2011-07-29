# encoding: utf-8
class Photo
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :caption, type: String
  field :cover, type: Boolean

  embedded_in :photographic, polymorphic: true

  # A single image is provided for each photo.
  mount_uploader :image, ImageUploader
end
