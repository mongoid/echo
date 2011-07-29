# encoding: utf-8
require "spec_helper"

describe Venue do

  context "when validating name presence" do

    let(:venue) do
      Fabricate.build(:venue, name: nil)
    end

    before do
      venue.valid?
    end

    it "must be provided" do
      venue.errors[:name].should == [ "can't be blank" ]
    end
  end
end
