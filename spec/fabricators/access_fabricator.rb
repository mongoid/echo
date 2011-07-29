# encoding: utf-8
Fabricator(:access) do
  category :download

  after_build do |access|
    band = Fabricate.build(:depeche_mode)
    album = band.albums.first
    access.album_id = album.id
    access.band = band
    access.track_id = album.tracks.first.id
  end
end

Fabricator(:download, from: :access)

Fabricator(:stream, from: :access) do
  category :stream
end
