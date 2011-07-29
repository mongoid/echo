# encoding: utf-8
Fabricator(:user) do
  email "durran@echo.am"
  first_name "Durran"
  last_name "Jordan"
  role do
    role = Reference::Role.first || Fabricate(:role)
    role.denormalized
  end
end

Fabricator(:admin, class_name: "User") do
  email "durran@echo.am"
  first_name "Durran"
  last_name "Jordan"
  role do
    role = Reference::Role.administrator || Fabricate(:administrator_role)
    role.denormalized
  end
end

Fabricator(:artist, class_name: "User") do
  email "east.bay.ray@kennedys.com"
  first_name "Raymond"
  last_name "Pepperell"
  handle "East Bay Ray"
  role do
    role = Reference::Role.artist || Fabricate(:artist_role)
    role.denormalized
  end
end

Fabricator(:producer, class_name: "User") do
  email "moses.schneider@echo.am"
  first_name "Moses"
  last_name "Schneider"
  role do
    role = Reference::Role.producer || Fabricate(:producer_role)
    role.denormalized
  end
end

Fabricator(:subscriber, class_name: "User") do
  email "joe.blow@gmail.com"
  first_name "Joe"
  last_name "Blow"
  role do
    role = Reference::Role.subscriber || Fabricate(:subscriber_role)
    role.denormalized
  end
end

Fabricator(:visitor, class_name: "User") do
  email "info@echo.am"
  first_name "Echo"
  last_name "Visitor"
  role do
    role = Reference::Role.visitor || Fabricate(:visitor_role)
    role.denormalized
  end
end

Fabricator(:daniel_miller, class_name: "User") do
  email "daniel.miller@echo.am"
  first_name "Daniel"
  last_name "Miller"
  role do
    role = Reference::Role.producer || Fabricate(:producer_role)
    role.denormalized
  end
end

