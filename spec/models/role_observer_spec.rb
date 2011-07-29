# encoding: utf-8
require "spec_helper"

describe RoleObserver do

  let(:observer) do
    RoleObserver.instance
  end

  describe "#before_create" do

    context "when specific band actions exist" do

      let(:band) do
        Fabricate.build(:band)
      end

      let(:user) do
        Fabricate.build(:artist, band: band)
      end

      let(:role) do
        Fabricate.build(:artist_role).denormalized
      end

      before do
        user.role = role
        observer.before_create(role)
      end

      it "interpolates the band actions" do
        role.actions["manage-band"].should == band.id
      end

      it "does not interpolate view actions" do
        role.actions["view-band"].should == :all
      end
    end

    context "when specific user actions exist" do

      let(:user) do
        Fabricate.build(:subscriber)
      end

      let(:role) do
        Fabricate.build(:subscriber_role).denormalized
      end

      before do
        user.role = role
        observer.before_create(role)
      end

      it "interpolates the user actions" do
        role.actions["manage-user"].should == user.id
      end

      it "does not interpolate view actions" do
        role.actions["view-user"].should == :all
      end
    end
  end
end
