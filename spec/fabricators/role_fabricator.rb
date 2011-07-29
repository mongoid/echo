# encoding: utf-8
Fabricator(:role, class_name: "Reference::Role") do
  name "administrator"
  actions do
    {
      "download-track" => :all,
      "manage-band" => :all,
      "manage-user" => :all,
      "stream-track" => :all,
      "view-band" => :all,
      "view-user" => :all
    }
  end
end

Fabricator(:administrator_role, from: :role)

Fabricator(:artist_role, class_name: "Reference::Role") do
  name "artist"
  actions do
    {
      "download-track" => :all,
      "manage-band" => :id,
      "manage-user" => :id,
      "stream-track" => :all,
      "view-band" => :all,
      "view-user" => :all
    }
  end
end

Fabricator(:producer_role, class_name: "Reference::Role") do
  name "producer"
  actions do
    {
      "download-track" => :all,
      "manage-user" => :id,
      "stream-track" => :all,
      "view-band" => :all,
      "view-user" => :all
    }
  end
end

Fabricator(:subscriber_role, class_name: "Reference::Role") do
  name "subscriber"
  actions do
    {
      "download-track" => :all,
      "manage-user" => :id,
      "stream-track" => :all,
      "view-band" => :all,
      "view-user" => :all
    }
  end
end

Fabricator(:visitor_role, class_name: "Reference::Role") do
  name "visitor"
  actions do
    {
      "stream-track" => :all,
      "view-band" => :all,
      "view-user" => :all
    }
  end
end
