Fabricator(:following) do
  user { Fabricate(:subscriber) }
  band { Fabricate(:band) }
end
