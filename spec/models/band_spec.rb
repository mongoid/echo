# encoding: utf-8
require "spec_helper"

describe Band do

  describe ".named" do

    let!(:band) do
      Fabricate(:band, name: "Beat Steaks")
    end

    context "when provided a name" do

      context "when the name matches" do

        let(:result) do
          Band.named("Beat Steaks")
        end

        it "returns the matching band" do
          result.should == band
        end
      end

      context "when the name does not match" do

        let(:result) do
          Band.named("Beat Sticks")
        end

        it "returns nil" do
          result.should be_nil
        end
      end
    end

    context "when provided nil" do

      it "returns nil" do
        Band.named(nil).should be_nil
      end
    end

    context "when provided an empty string" do

      it "returns nil" do
        Band.named("").should be_nil
      end
    end
  end

  describe "#producers" do

    let(:band) do
      Fabricate(:nine_inch_nails)
    end

    let(:producers) do
      band.producers
    end

    it "returns all producers for all albums" do
      producers.first.name.should == "Daniel Miller"
    end
  end

  describe ".reviewed_by" do

    let(:band) do
      Fabricate(:band)
    end

    let!(:unreviewed) do
      Fabricate(:band, name: "Radiohead")
    end

    let(:album) do
      Fabricate.build(:album)
    end

    let(:review) do
      Fabricate.build(:review)
    end

    before do
      album.reviews << review
      band.albums << album
    end

    let(:reviewer) do
      review.reviewer
    end

    let(:bands) do
      Band.reviewed_by(reviewer)
    end

    it "returns the bands with the provided reviewer" do
      bands.should == [ band ]
    end
  end

  describe "#reviews" do

    let(:band) do
      Fabricate(:band)
    end

    let(:album) do
      Fabricate.build(:album)
    end

    let(:review) do
      Fabricate.build(:review)
    end

    before do
      album.reviews << review
      band.albums << album
    end

    it "returns the band's reviews" do
      band.reviews.should == [ review ]
    end
  end

  describe "#reviews_by" do

    let(:band) do
      Fabricate(:band)
    end

    let(:album) do
      Fabricate.build(:album)
    end

    let(:review) do
      Fabricate.build(:review)
    end

    let(:reviewer) do
      review.reviewer
    end

    before do
      album.reviews << review
      band.albums << album
    end

    it "returns the reviews for the provided user" do
      band.reviews_by(reviewer).should == [ review ]
    end
  end

  describe "#searchables" do

    let(:band) do
      Fabricate(:depeche_mode)
    end

    let(:searchables) do
      band.searchables
    end

    it "includes genres" do
      searchables.should include("Electronic")
    end

    it "includes the name" do
      searchables.should include("Depeche Mode")
    end

    it "includes producer names" do
      searchables.should include("Daniel Miller")
    end

    it "includes similarities" do
      searchables.should include("New Order")
    end

    it "includes sounds" do
      searchables.should include("Piano")
    end
  end

  context "when validating name presence" do

    let(:band) do
      Fabricate.build(:band, name: nil)
    end

    before do
      band.valid?
    end

    it "must be provided" do
      band.errors[:name].should == [ "can't be blank" ]
    end
  end

  context "when validating name uniqueness" do

    let(:band) do
      Fabricate.build(:band)
    end

    before do
      Fabricate(:band)
      band.valid?
    end

    it "must be unique" do
      band.errors[:name].should == [ "is already taken" ]
    end
  end
end
