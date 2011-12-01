class ShowsController < InheritedResources::Base
  nested_belongs_to :band, :tour
end
