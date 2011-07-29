# encoding: utf-8
require "spec_helper"

describe Tour do

  context "when validating name presence" do

    let(:tour) do
      Fabricate.build(:tour, name: nil)
    end

    before do
      tour.valid?
    end

    it "must be provided" do
      tour.errors[:name].should == [ "can't be blank" ]
    end
  end
end
