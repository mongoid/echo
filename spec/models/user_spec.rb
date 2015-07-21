# encoding: utf-8
require "spec_helper"

describe User do

  describe "#able_to?" do

    context "when the user can perform the action" do

      let(:user) do
        Fabricate.build(:admin)
      end

      it "returns true" do
        user.should be_able_to("manage-user")
      end
    end

    context "when the user cannot perform the action" do

      let(:user) do
        Fabricate.build(:subscriber)
      end

      it "returns false" do
        user.should_not be_able_to("manage-user")
      end
    end
  end

  describe ".administrators" do

    let!(:user) do
      Fabricate(:admin)
    end

    let(:admins) do
      User.administrators
    end

    it "returns all admin users" do
      admins.should == [ user ]
    end
  end

  describe "#administrator?" do

    context "when the user is an administrator" do

      let(:user) do
        Fabricate.build(:admin)
      end

      it "returns true" do
        user.should be_administrator
      end
    end

    context "when the user is not an administrator" do

      let(:user) do
        Fabricate.build(:artist)
      end

      it "returns false" do
        user.should_not be_administrator
      end
    end
  end

  describe ".artists" do

    let!(:user) do
      Fabricate(:artist)
    end

    let(:artists) do
      User.artists
    end

    it "returns all artist users" do
      artists.should == [ user ]
    end
  end

  describe "#artist?" do

    context "when the user is an artist" do

      let(:user) do
        Fabricate.build(:artist)
      end

      it "returns true" do
        user.should be_artist
      end
    end

    context "when the user is not an artist" do

      let(:user) do
        Fabricate.build(:admin)
      end

      it "returns false" do
        user.should_not be_artist
      end
    end
  end

  describe "#follow" do

    let!(:user) do
      Fabricate(:subscriber)
    end

    let!(:band) do
      Fabricate(:band)
    end

    before do
      user.follow(band)
    end

    it "adds a following to the user" do
      user.followings.count.should == 1
    end

    it "adds a following to the band" do
      band.followings.count.should == 1
    end
  end

  describe "#name" do

    context "when a handle exists" do

      let(:user) do
        Fabricate.build(:artist)
      end

      it "returns the handle" do
        user.name.should == "East Bay Ray"
      end
    end

    context "when a handle does not exist" do

      let(:user) do
        Fabricate.build(:subscriber)
      end

      it "returns the first and last name" do
        user.name.should == "Joe Blow"
      end
    end
  end

  describe "#producer?" do

    context "when the user is a procuder" do

      let(:user) do
        Fabricate.build(:producer)
      end

      it "returns true" do
        user.should be_producer
      end
    end

    context "when the user is not a producer" do

      let(:user) do
        Fabricate.build(:artist)
      end

      it "returns false" do
        user.should_not be_producer
      end
    end
  end

  describe ".producers" do

    let!(:user) do
      Fabricate(:producer)
    end

    let(:producers) do
      User.producers
    end

    it "returns all producer users" do
      producers.should == [ user ]
    end
  end

  describe "#productions" do

    let!(:user) do
      Fabricate(:producer)
    end

    let!(:band) do
      Fabricate(:band)
    end

    let!(:album) do
      Fabricate.build(:album, producer: user)
    end

    before do
      band.albums << album
    end

    it "returns the albums produced" do
      user.productions.should == [ album ]
    end
  end

  describe "#reviews" do

    let(:band) do
      Fabricate(:band)
    end

    let(:album) do
      Fabricate.build(:album)
    end

    let(:user) do
      Fabricate(:subscriber)
    end

    let(:review) do
      Fabricate.build(:review, reviewer: user)
    end

    before do
      band.albums << album
      album.reviews << review
    end

    let(:reviews) do
      user.reviews
    end

    it "returns the reviews the user authored" do
      user.reviews.should == [ review ]
    end
  end

  describe ".subscribe" do

    before do
      Fabricate(:subscriber_role)
    end

    context "when the subscription is successful" do

      let!(:subscribe) do
        User.subscribe("syd.vicious@pistols.net")
      end

      let(:user) do
        User.where(email: "syd.vicious@pistols.net").first
      end

      it "sets the users role to a subscriber" do
        user.role.name.should == "subscriber"
      end

      it "returns true" do
        subscribe.should be true
      end
    end
  end

  describe "#subscriber?" do

    context "when the user is a subscriber" do

      let(:user) do
        Fabricate.build(:subscriber)
      end

      it "returns true" do
        user.should be_subscriber
      end
    end

    context "when the user is not a subscriber" do

      let(:user) do
        Fabricate.build(:artist)
      end

      it "returns false" do
        user.should_not be_subscriber
      end
    end
  end

  describe ".subscribers" do

    let!(:user) do
      Fabricate(:subscriber)
    end

    let(:subscribers) do
      User.subscribers
    end

    it "returns all subscribers" do
      subscribers.should == [ user ]
    end
  end

  describe "#unfollow" do

    let!(:user) do
      Fabricate(:subscriber)
    end

    let!(:band) do
      Fabricate(:band)
    end

    before do
      user.follow(band)
      user.unfollow(band)
    end

    it "removes the following from the user" do
      user.followings.count.should == 0
    end

    it "removes the following from the band" do
      band.followings.count.should == 0
    end
  end

  describe "#visitor?" do

    context "when the user is a visitor" do

      let(:user) do
        Fabricate.build(:visitor)
      end

      it "returns true" do
        user.should be_visitor
      end
    end

    context "when the user is not a visitor" do

      let(:user) do
        Fabricate.build(:artist)
      end

      it "returns false" do
        user.should_not be_visitor
      end
    end
  end

  context "when validating email presence" do

    let(:user) do
      Fabricate.build(:user, email: nil)
    end

    before do
      user.valid?
    end

    it "must be provided" do
      user.errors[:email].should == [ "can't be blank" ]
    end
  end

  context "when validating email uniqueness" do

    let(:user) do
      Fabricate.build(:user)
    end

    before do
      Fabricate(:user)
      user.valid?
    end

    it "must be unique" do
      user.errors[:email].should == [ "is already taken" ]
    end
  end

  context "when validating role presence" do

    let(:user) do
      Fabricate.build(:user, role: nil)
    end

    before do
      user.valid?
    end

    it "must be provided" do
      user.errors[:role].should == [ "can't be blank" ]
    end
  end
end
