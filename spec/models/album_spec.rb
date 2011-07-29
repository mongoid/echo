# encoding: utf-8
require "spec_helper"

describe Album do

  describe "#average_rating" do

    let(:band) do
      Fabricate(:band)
    end

    let(:album) do
      Fabricate.build(:album)
    end

    let(:review_one) do
      Fabricate.build(:review, rating: 5)
    end

    let(:review_two) do
      Fabricate.build(:review, rating: 10)
    end

    before do
      band.albums << album
      album.reviews << [ review_one, review_two ]
    end

    it "returns the average review rating" do
      album.average_rating.should == 7.5
    end
  end

  describe "#discs" do

    context "when the album has only 1 disc" do

      let(:album) do
        Fabricate.build(:album)
      end

      before do
        album.tracks << Fabricate.build(:track)
      end

      it "returns 1" do
        album.discs.should == 1
      end
    end

    context "when the album has multiple discs" do

      let(:album) do
        Fabricate.build(:singles_86_98)
      end

      it "returns the total number of discs" do
        album.discs.should == 2
      end
    end
  end

  describe ".produced_by" do

    let(:user) do
      Fabricate(:producer)
    end

    let(:band) do
      Fabricate.build(:band)
    end

    let(:first_album) do
      Fabricate.build(:album, producer: user)
    end

    let(:second_album) do
      Fabricate.build(:album)
    end

    before do
      band.albums << [ first_album, second_album ]
    end

    let(:albums) do
      band.albums.produced_by(user)
    end

    it "returns the albums produced by the user" do
      albums.should == [ first_album ]
    end
  end

  context "when validating name presence" do

    let(:album) do
      Fabricate.build(:album, name: nil)
    end

    before do
      album.valid?
    end

    it "must be provided" do
      album.errors[:name].should == [ "can't be blank" ]
    end
  end
end
