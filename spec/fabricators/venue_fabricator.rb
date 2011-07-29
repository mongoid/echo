# encoding: utf-8
Fabricator(:venue) do
  name "Columbiahalle"
  location [ 52.48445, 13.39269 ]

  after_build do |venue|
    venue.address = Fabricate.build(:address)
  end
end
