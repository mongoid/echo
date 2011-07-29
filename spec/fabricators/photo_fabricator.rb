# encoding: utf-8
DIR = "#{Rails.root}/spec/support/bands/depeche-mode"
DM_TABLE = "#{DIR}/depeche-mode-table.jpg"
DM_UNIVERSE = "#{DIR}/depeche-mode-universe.jpg"
DM_WALL = "#{DIR}/depeche-mode-wall.jpg"
SINGLES_BACK = "#{DIR}/singles-86-98-back.jpg"
SINGLES_COVER = "#{DIR}/singles-86-98-cover.jpg"

Fabricator(:photo) do
  caption "Depeche Mode"
  cover false
  image File.new(DM_TABLE)
end

Fabricator(:depeche_mode_table, class_name: "Photo") do
  caption "Depeche Mode at a table."
  cover false
  image File.new(DM_TABLE)
end

Fabricator(:depeche_mode_universe, class_name: "Photo") do
  caption "Depeche Mode outside."
  cover false
  image File.new(DM_UNIVERSE)
end

Fabricator(:depeche_mode_wall, class_name: "Photo") do
  caption "Depeche Mode at the wall."
  cover true
  image File.new(DM_WALL)
end

Fabricator(:singles_86_98_cover, class_name: "Photo") do
  caption "The Singles 86 > 98 Cover."
  cover true
  image File.new(SINGLES_COVER)
end

Fabricator(:singles_86_98_back, class_name: "Photo") do
  caption "The Singles 86 > 98 Back."
  cover false
  image File.new(SINGLES_BACK)
end
