# encoding: utf-8
require 'spec_helper'

describe "Tours" do
  describe "GET /bands/1/tours" do
    describe "listing of tours" do
      let!(:band) { Fabricate(:nine_inch_nails, tours: [Fabricate.build(:tour)]) }
      let(:tour) { band.tours.first }

      before(:each) do
        visit band_path(band)
        click_link "Tours"
      end

      it "name" do
        page.should have_link tour.name, href: band_tour_path(band, tour)
      end

      it "edit and destroy links" do
        page.should have_link "Edit", href: edit_band_tour_path(band, tour)
        page.should have_link "Destroy", href: band_tour_path(band, tour)
      end
    end
  end

  describe "GET /bands/1/tours/new" do
    let!(:band) { Fabricate(:nine_inch_nails) }

    before(:each) do
      visit band_tours_path(band)
      click_link "New Tour"
    end

    it "shows form" do
      page.should have_field "Name"
    end

    it "creates tour" do
      fill_in "Name", with: "Self Destruct Tour"

      click_button "Create Tour"

      page.should have_content "Tour was successfully created."

      page.should have_content "Self Destruct Tour"
    end
  end

  describe "GET /bands/1/tours/2" do
    let!(:band) { Fabricate(:nine_inch_nails, tours: [Fabricate.build(:tour)]) }
    let(:tour) { band.tours.first }

    before(:each) do
      visit band_tours_path(band)
      click_link tour.name
    end

    it "tour name" do
      page.should have_content tour.name
    end
  end

  describe "GET /bands/1/tours/2/edit" do
    let!(:band) { Fabricate(:nine_inch_nails, tours: [Fabricate.build(:tour)]) }
    let(:tour) { band.tours.first }

    before(:each) do
      visit band_tour_path(band, tour)
      click_link "Edit"
    end

    it "shows current data in form" do
      page.should have_field "Name", with: tour.name
    end

    describe "edit fields" do
      it "name" do
        fill_in "Name", with: "Self Destruct Tour"

        click_button "Update Tour"
        page.should have_content "Tour was successfully updated."

        page.should have_content "Self Destruct Tour"
      end
    end
  end

  describe "GET /bands/1/tours/2/destroy" do
    let!(:band) { Fabricate(:nine_inch_nails, tours: [Fabricate.build(:tour)]) }
    let(:tour) { band.tours.first }

    it "destroys", js: true do
      visit band_tours_path(band)

      page.should have_link tour.name

      handle_js_confirm do
        click_link "Destroy"
      end

      page.should_not have_link tour.name
    end
  end
end
