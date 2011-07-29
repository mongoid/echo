# encoding: utf-8
require "spec_helper"

describe Track do

  describe "#send_to" do

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

    let!(:download) do
      track.send_to(user)
    end

    it "returns a new access document" do
      download.should be_a(Access)
    end

    it "sets the track id on the access" do
      download.track_id.should == track.id
    end

    it "sets the album id on the access" do
      download.album_id.should == track.album.id
    end

    it "sets the band on the access" do
      download.band.should == track.album.band
    end

    it "sets the access category to download" do
      download.should be_download
    end

    it "sets the user on the access" do
      download.user.should == user
    end

    it "increments the downloads" do
      track.downloads.should == 1
    end
  end

  describe "#stream_to" do

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

    let!(:download) do
      track.stream_to(user)
    end

    it "returns a new access document" do
      download.should be_a(Access)
    end

    it "sets the track id on the access" do
      download.track_id.should == track.id
    end

    it "sets the album id on the access" do
      download.album_id.should == track.album.id
    end

    it "sets the band on the access" do
      download.band.should == track.album.band
    end

    it "sets the access category to stream" do
      download.should be_stream
    end

    it "sets the user on the access" do
      download.user.should == user
    end

    it "increments the streams" do
      track.streams.should == 1
    end
  end

  context "when validating disc presence" do

    let(:track) do
      Fabricate.build(:track, disc: nil)
    end

    before do
      track.valid?
    end

    it "must be provided" do
      track.errors[:disc].should == [ "can't be blank" ]
    end
  end

  context "when validating length presence" do

    let(:track) do
      Fabricate.build(:track, length: nil)
    end

    before do
      track.valid?
    end

    it "must be provided" do
      track.errors[:length].should == [ "can't be blank" ]
    end
  end

  context "when validating name presence" do

    let(:track) do
      Fabricate.build(:track, name: nil)
    end

    before do
      track.valid?
    end

    it "must be provided" do
      track.errors[:name].should == [ "can't be blank" ]
    end
  end

  context "when validating number presence" do

    let(:track) do
      Fabricate.build(:track, number: nil)
    end

    before do
      track.valid?
    end

    it "must be provided" do
      track.errors[:number].should == [ "can't be blank" ]
    end
  end
end
