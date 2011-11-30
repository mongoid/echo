# encoding: utf-8
require 'spec_helper'

describe "Bands" do
  describe "GET /bands" do
    describe "listing of bands" do
      let!(:band) { Fabricate(:depeche_mode) }

      before(:each) do
        visit root_path
        click_link "Bands"
      end

      it "band name" do
        page.should have_link band.name, href: band_path(band)
      end

      it "location of band" do
        page.should have_content band.location
      end

      it "edit and destroy links" do
        page.should have_link "Edit", href: edit_band_path(band)
        page.should have_link "Destroy", href: band_path(band)
      end
    end
  end

  describe "GET /bands/new" do
    before(:each) do
      visit bands_path
      click_link "New Band"
    end

    it "shows form" do
      page.should have_field "Name"
      page.should have_field "Description"
      page.should have_field "Formed on"
      page.should have_field "Location"
      page.should have_field "Website"
    end

    it "creates band" do
      fill_in "Name", with: "Franz Ferdinand"
      fill_in "Description", with: "A Glasgow based post-punk revival band."
      fill_in "Formed on", with: "01.01.2002"
      fill_in "Location", with: "Glasgow, Scotland"
      fill_in "Website", with: "http://www.franzferdinand.co.uk"

      click_button "Create Band"

      page.should have_content "Band was successfully created."

      page.should have_content "Franz Ferdinand"
      page.should have_content "A Glasgow based post-punk revival band."
      page.should have_content "2002-01-01"
      page.should have_content "Glasgow, Scotland"
      page.should have_link "http://www.franzferdinand.co.uk", href: "http://www.franzferdinand.co.uk"
    end
  end

  describe "GET /bands/1" do
    let!(:band) { Fabricate(:depeche_mode) }

    before(:each) do
      visit bands_path
      click_link band.name
    end

    it "band name" do
      page.should have_content band.name
    end

    it "description" do
      page.should have_content band.description
    end

    it "formed on" do
      page.should have_content band.formed_on
    end

    it "location" do
      page.should have_content band.location
    end

    it "website" do
      page.should have_content band.website
    end
  end

  describe "GET /bands/1/edit" do
    let!(:band) { Fabricate(:nine_inch_nails, formed_on: "1988-04-03", location: "Cleveland, Ohio, United States", website: "http://www.nin.com") }

    before(:each) do
      visit band_path(band)
      click_link "Edit"
    end

    it "shows current data in form" do
      page.should have_field "Name", with: band.name
      page.should have_field "Description", with: band.description
      page.should have_field "Formed on", with: band.formed_on.to_s
      page.should have_field "Location", with: band.location
      page.should have_field "Website", with: band.website
    end

    describe "edit fields" do
      it "name" do
        fill_in "Name", with: "Franz Ferdinand"

        click_button "Update Band"
        page.should have_content "Band was successfully updated."

        page.should have_content "Franz Ferdinand"
      end

      it "description" do
        fill_in "Description", with: "A Glasgow based post-punk revival band."

        click_button "Update Band"
        page.should have_content "Band was successfully updated."

        page.should have_content "A Glasgow based post-punk revival band."
      end

      it "formed on" do
        fill_in "Formed on", with: "01.01.2002"

        click_button "Update Band"
        page.should have_content "Band was successfully updated."

        page.should have_content "2002-01-01"
      end

      it "location" do
        fill_in "Location", with: "Glasgow, Scotland"

        click_button "Update Band"
        page.should have_content "Band was successfully updated."

        page.should have_content "Glasgow, Scotland"
      end

      it "website" do
        fill_in "Website", with: "http://www.franzferdinand.co.uk"

        click_button "Update Band"
        page.should have_content "Band was successfully updated."

        page.should have_link "http://www.franzferdinand.co.uk", href: "http://www.franzferdinand.co.uk"
      end
    end
  end

  describe "POST /bands/1/destroy" do
    let!(:band) { Fabricate(:nine_inch_nails) }

    it "destroys", js: true do
      visit bands_path

      page.should have_link band.name

      handle_js_confirm do
        click_link "Destroy"
      end

      page.should_not have_link band.name
    end
  end
end
