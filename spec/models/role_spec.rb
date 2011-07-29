# encoding: utf-8
require "spec_helper"

describe Role do

  describe "#able_to?" do

    context "when the role can perform the action" do

      context "when the action is general" do

        let(:role) do
          Role.new(actions: { "manage.user" => :all })
        end

        it "returns true" do
          role.should be_able_to("manage.user")
        end
      end

      context "when the action is document specific" do

        let(:user) do
          Fabricate.build(:user)
        end

        let(:role) do
          Role.new(actions: { "manage.user" => user.id })
        end

        it "returns true" do
          role.should be_able_to("manage.user", user)
        end
      end
    end

    context "when the role cannot perform the action" do

      let(:role) do
        Role.new
      end

      it "returns false" do
        role.should_not be_able_to("manage.user")
      end
    end
  end

  describe "#administrator?" do

    context "when the role is an administrator" do

      let(:role) do
        Fabricate.build(:administrator_role).denormalized
      end

      it "returns true" do
        role.should be_administrator
      end
    end

    context "when the role is not an administrator" do

      let(:role) do
        Fabricate.build(:artist_role).denormalized
      end

      it "returns false" do
        role.should_not be_administrator
      end
    end
  end

  describe "#artist?" do

    context "when the role is an artist" do

      let(:role) do
        Fabricate.build(:artist_role).denormalized
      end

      it "returns true" do
        role.should be_artist
      end
    end

    context "when the role is not an artist" do

      let(:role) do
        Fabricate.build(:administrator_role).denormalized
      end

      it "returns false" do
        role.should_not be_artist
      end
    end
  end

  describe "#producer?" do

    context "when the role is a procuder" do

      let(:role) do
        Fabricate.build(:producer_role).denormalized
      end

      it "returns true" do
        role.should be_producer
      end
    end

    context "when the role is not a producer" do

      let(:role) do
        Fabricate.build(:artist_role).denormalized
      end

      it "returns false" do
        role.should_not be_producer
      end
    end
  end

  describe "#subscriber?" do

    context "when the role is a subscriber" do

      let(:role) do
        Fabricate.build(:subscriber_role).denormalized
      end

      it "returns true" do
        role.should be_subscriber
      end
    end

    context "when the role is not a subscriber" do

      let(:role) do
        Fabricate.build(:artist_role).denormalized
      end

      it "returns false" do
        role.should_not be_subscriber
      end
    end
  end

  describe "#visitor?" do

    context "when the role is a visitor" do

      let(:role) do
        Fabricate.build(:visitor_role).denormalized
      end

      it "returns true" do
        role.should be_visitor
      end
    end

    context "when the role is not a visitor" do

      let(:role) do
        Fabricate.build(:artist_role).denormalized
      end

      it "returns false" do
        role.should_not be_visitor
      end
    end
  end
end
