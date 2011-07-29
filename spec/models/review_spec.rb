# encoding: utf-8
require "spec_helper"

describe Review do

  context "when validating content presence" do

    let(:review) do
      Fabricate.build(:review, content: nil)
    end

    before do
      review.valid?
    end

    it "must be provided" do
      review.errors[:content].should == [ "can't be blank" ]
    end
  end

  context "when validating rating value" do

    context "when the rating is below the minimum" do

      let(:review) do
        Fabricate.build(:review, rating: -1)
      end

      before do
        review.valid?
      end

      it "must be equal to or above 0" do
        review.errors[:rating].should ==
          [ "must be greater than or equal to 0" ]
      end
    end

    context "when the rating is above the maximum" do

      let(:review) do
        Fabricate.build(:review, rating: 11)
      end

      before do
        review.valid?
      end

      it "must be equal to or below 10" do
        review.errors[:rating].should ==
          [ "must be less than or equal to 10" ]
      end
    end
  end

  context "when validating reviewer presence" do

    let(:review) do
      Fabricate.build(:review, reviewer: nil)
    end

    before do
      review.valid?
    end

    it "must be provided" do
      review.errors[:reviewer].should == [ "can't be blank" ]
    end
  end
end
