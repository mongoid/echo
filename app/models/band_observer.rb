# encoding: utf-8
class BandObserver < Mongoid::Observer

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
end
