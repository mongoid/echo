# encoding: utf-8
require "spec_helper"

describe Show do

  context "when validating date presence" do

    let(:show) do
      Fabricate.build(:show, date: nil)
    end

    before do
      show.valid?
    end

    it "must be provided" do
      show.errors[:date].should == [ "can't be blank" ]
    end
  end
end
