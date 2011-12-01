# encoding: utf-8
require 'spec_helper'

describe "Shows" do
  describe "GET /bands/1/tours/2/shows" do
    describe "listing of shows" do
      let!(:band) { Fabricate(:nine_inch_nails, tours: [Fabricate.build(:tour, shows: [Fabricate.build(:show, venue: Fabricate.build(:venue))])]) }
      let(:tour) { band.tours.first }
      let(:show) { tour.shows.first }

      before(:each) do
        visit band_tour_path(band, tour)
        click_link "Shows"
      end

      it "name" do
        page.should have_link show.date.to_s, href: band_tour_show_path(band, tour, show)
      end

      it "venue name" do
        page.should have_content show.venue.name
      end

      it "edit and destroy links" do
        page.should have_link "Edit", href: edit_band_tour_show_path(band, tour, show)
        page.should have_link "Destroy", href: band_tour_show_path(band, tour, show)
      end
    end
  end

  describe "GET /bands/1/tours/2/shows/new" do
    let!(:band) { Fabricate(:nine_inch_nails, tours: [Fabricate.build(:tour)]) }
    let(:tour) { band.tours.first }

    before(:each) do
      visit band_tour_shows_path(band, tour)
      click_link "New Show"
    end

    it "shows form" do
      page.should have_field "Date"

      within_fieldset("Venue") do
        page.should have_field "Name"
      end
    end

    it "creates show" do
      fill_in "Date", with: "25.12.2010"

      within_fieldset("Venue") do
        fill_in "Name", with: "Olympiastadion"
      end

      click_button "Create Show"

      page.should have_content "Show was successfully created."

      page.should have_content "2010-12-25"

      within(".venue") do
        page.should have_content "Olympiastadion"
      end
    end
  end

  describe "GET /bands/1/tours/2/shows/3" do
    let!(:band) { Fabricate(:nine_inch_nails, tours: [Fabricate.build(:tour, shows: [Fabricate.build(:show, venue: Fabricate.build(:venue))])]) }
    let(:tour) { band.tours.first }
    let(:show) { tour.shows.first }

    before(:each) do
      visit band_tour_shows_path(band, tour)
      click_link show.date.to_s
    end

    it "date" do
      page.should have_content show.date.to_s
    end

    it "venue name" do
      within(".venue") do
        page.should have_content show.venue.name
      end
    end
  end

  describe "GET /bands/1/tours/2/shows/3/edit" do
    let!(:band) { Fabricate(:nine_inch_nails, tours: [Fabricate.build(:tour, shows: [Fabricate.build(:show, venue: Fabricate.build(:venue))])]) }
    let(:tour) { band.tours.first }
    let(:show) { tour.shows.first }

    before(:each) do
      visit band_tour_show_path(band, tour, show)
      click_link "Edit"
    end

    it "shows current data in form" do
      page.should have_field "Date", with: show.date.to_s

      within_fieldset("Venue") do
        page.should have_field "Name", with: show.venue.name
      end
    end

    describe "edit fields" do
      it "date" do
        fill_in "Date", with: "25.12.2010"

        click_button "Update Show"
        page.should have_content "Show was successfully updated."

        page.should have_content "2010-12-25"
      end

      it "venue name" do
        within_fieldset("Venue") do
          fill_in "Name", with: "Olympiastadion"
        end

        click_button "Update Show"
        page.should have_content "Show was successfully updated."

        within(".venue") do
          page.should have_content "Olympiastadion"
        end
      end
    end
  end

  describe "GET /bands/1/tours/2/shows/3/destroy" do
    let!(:band) { Fabricate(:nine_inch_nails, tours: [Fabricate.build(:tour, shows: [Fabricate.build(:show, venue: Fabricate.build(:venue))])]) }
    let(:tour) { band.tours.first }
    let(:show) { tour.shows.first }

    it "destroys", js: true do
      visit band_tour_shows_path(band, tour)

      page.should have_link show.date.to_s

      handle_js_confirm do
        click_link "Destroy"
      end

      page.should_not have_link show.date.to_s
    end
  end  
end
