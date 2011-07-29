# encoding: utf-8
require "spec_helper"

describe Reference::Role do

  describe ".administrator" do

    let!(:administrator) do
      Fabricate(:administrator_role)
    end

    it "returns the only administrator" do
      Reference::Role.administrator.should == administrator
    end
  end

  describe ".administrators" do

    let!(:administrator) do
      Fabricate(:administrator_role)
    end

    it "returns the administrator role in an array" do
      Reference::Role.administrators.should == [ administrator ]
    end
  end

  describe ".artist" do

    let!(:artist) do
      Fabricate(:artist_role)
    end

    it "returns the only artist" do
      Reference::Role.artist.should == artist
    end
  end

  describe ".artists" do

    let!(:artist) do
      Fabricate(:artist_role)
    end

    it "returns the artist role in an array" do
      Reference::Role.artists.should == [ artist ]
    end
  end

  describe "#denormalized" do

    let!(:reference) do
      Fabricate.build(:role, name: "administrator", actions: {})
    end

    let(:denormalized) do
      reference.denormalized
    end

    it "returns a denormalized role" do
      denormalized.should be_a(::Role)
    end

    it "sets the name on the denormalized role" do
      denormalized.name.should == reference.name
    end

    it "sets the actions on the denormalized role" do
      denormalized.actions.should == reference.actions
    end

    it "sets the role id on the denormalized role" do
      denormalized.role_id.should == reference.id
    end
  end

  describe ".producer" do

    let!(:producer) do
      Fabricate(:producer_role)
    end

    it "returns the only producer" do
      Reference::Role.producer.should == producer
    end
  end

  describe ".producers" do

    let!(:producer) do
      Fabricate(:producer_role)
    end

    it "returns the producer role in an array" do
      Reference::Role.producers.should == [ producer ]
    end
  end

  describe ".subscriber" do

    let!(:subscriber) do
      Fabricate(:subscriber_role)
    end

    it "returns the only subscriber" do
      Reference::Role.subscriber.should == subscriber
    end
  end

  describe ".subscribers" do

    let!(:subscriber) do
      Fabricate(:subscriber_role)
    end

    it "returns the subscriber role in an array" do
      Reference::Role.subscribers.should == [ subscriber ]
    end
  end

  context "when validating name uniqueness" do

    let(:role) do
      Fabricate.build(:role)
    end

    before do
      Fabricate(:role)
      role.valid?
    end

    it "must be unique" do
      role.errors[:name].should == [ "is already taken" ]
    end
  end

  context "when validating name presence" do

    let(:role) do
      Fabricate.build(:role, name: nil)
    end

    before do
      role.valid?
    end

    it "must be provided" do
      role.errors[:name].should == [ "can't be blank" ]
    end
  end
end
