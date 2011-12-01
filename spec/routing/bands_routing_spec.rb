require "spec_helper"

describe BandsController do
  describe "routing" do

    it "routes to #index" do
      get("/bands").should route_to("bands#index")
    end

    it "routes to #new" do
      get("/bands/new").should route_to("bands#new")
    end

    it "routes to #show" do
      get("/bands/1").should route_to("bands#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bands/1/edit").should route_to("bands#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bands").should route_to("bands#create")
    end

    it "routes to #update" do
      put("/bands/1").should route_to("bands#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bands/1").should route_to("bands#destroy", :id => "1")
    end

  end
end
