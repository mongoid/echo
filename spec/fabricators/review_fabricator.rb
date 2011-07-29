Fabricator(:review) do
  content "This is the greatest album of all time."
  rating 9.5
  reviewer { User.subscribers.first || Fabricate(:subscriber) }
end
