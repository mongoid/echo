# encoding: utf-8
require "spec_helper"

describe Access do

  describe "#download?" do

    context "when the access is a download" do

      let(:access) do
        Fabricate.build(:download)
      end

      it "returns true" do
        access.should be_download
      end
    end

    context "when the access is not a download" do

      let(:access) do
        Fabricate.build(:stream)
      end

      it "returns false" do
        access.should_not be_download
      end
    end
  end

  describe ".downloaded" do

    let(:user) do
      Fabricate.build(:subscriber)
    end

    let(:band) do
      Fabricate.build(:nine_inch_nails)
    end

    let(:album) do
      band.albums.first
    end

    let(:track) do
      album.tracks.first
    end

    let(:access) do
      Access.downloaded(track, user)
    end

    it "returns a download access" do
      access.should be_download
    end

    it "sets the album id" do
      access.album_id.should == album.id
    end

    it "sets the band" do
      access.band.should == band
    end

    it "sets the track id" do
      access.track_id.should == track.id
    end

    it "sets the user" do
      access.user.should == user
    end
  end

  describe "#stream?" do

    context "when the access is a stream" do

      let(:access) do
        Fabricate.build(:stream)
      end

      it "returns true" do
        access.should be_stream
      end
    end

    context "when the access is not a stream" do

      let(:access) do
        Fabricate.build(:download)
      end

      it "returns false" do
        access.should_not be_stream
      end
    end
  end

  describe ".streamed" do

    let(:user) do
      Fabricate.build(:subscriber)
    end

    let(:band) do
      Fabricate.build(:nine_inch_nails)
    end

    let(:album) do
      band.albums.first
    end

    let(:track) do
      album.tracks.first
    end

    let(:access) do
      Access.streamed(track, user)
    end

    it "returns a stream access" do
      access.should be_stream
    end

    it "sets the album id" do
      access.album_id.should == album.id
    end

    it "sets the band" do
      access.band.should == band
    end

    it "sets the track id" do
      access.track_id.should == track.id
    end

    it "sets the user" do
      access.user.should == user
    end
  end

  [ :album_id, :band, :category, :track_id, :user ].each do |field|

    context "when validating #{field} presence" do

      let(:access) do
        Fabricate.build(:access)
      end

      before do
        access.send("#{field}=", nil)
        access.valid?
      end

      it "must be provided" do
        access.errors[field].should == [ "can't be blank" ]
      end
    end
  end
end
