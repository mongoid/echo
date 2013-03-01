class Site
  include Mongoid::Document

  field :host
  field :db_name

  def online?
    true
  end
end
