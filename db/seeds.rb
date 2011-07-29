# encoding: utf-8

# Create the basic reference roles for the application. These are based off the
# roles defined in the reference role.
Reference::Role::TYPES.each do |role|
  actions = case role
    when :administrator
      {
        "download-track" => :all,
        "manage-band" => :all,
        "manage-user" => :all,
        "stream-track" => :all,
        "view-band" => :all,
        "view-user" => :all
      }
    when :artist
      {
        "download-track" => :all,
        "manage-band" => :id,
        "manage-user" => :id,
        "stream-track" => :all,
        "view-band" => :all,
        "view-user" => :all
      }
    when :producer
      {
        "download-track" => :all,
        "manage-user" => :id,
        "stream-track" => :all,
        "view-band" => :all,
        "view-user" => :all
      }
    when :subscriber
      {
        "download-track" => :all,
        "manage-user" => :id,
        "stream-track" => :all,
        "view-band" => :all,
        "view-user" => :all
      }
    when :visitor
      {
        "stream-track" => :all,
        "view-band" => :all,
        "view-user" => :all
      }
  end
  Reference::Role.create!(name: role.to_s, actions: actions)
end
