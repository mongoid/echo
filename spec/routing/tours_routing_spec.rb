require "spec_helper"

describe ToursController do
  describe "routing" do

    it "routes to #index" do
      get("/bands/1/tours").should route_to("tours#index", band_id: "1")
    end

    it "routes to #new" do
      get("/bands/1/tours/new").should route_to("tours#new", band_id: "1")
    end

    it "routes to #show" do
      get("/bands/1/tours/2").should route_to("tours#show", band_id: "1", id: "2")
    end

    it "routes to #edit" do
      get("/bands/1/tours/2/edit").should route_to("tours#edit", band_id: "1", id: "2")
    end

    it "routes to #create" do
      post("/bands/1/tours").should route_to("tours#create", band_id: "1")
    end

    it "routes to #update" do
      put("/bands/1/tours/2").should route_to("tours#update", band_id: "1", id: "2")
    end

    it "routes to #destroy" do
      delete("/bands/1/tours/2").should route_to("tours#destroy", band_id: "1", id: "2")
    end
  end
end
