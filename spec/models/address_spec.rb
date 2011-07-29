# encoding: utf-8
require "spec_helper"

describe Address do

  [ :city, :country, :postcode, :street ].each do |field|

    context "when validating #{field} presence" do

      let(:address) do
        Fabricate.build(:address, "#{field}" => nil)
      end

      before do
        address.valid?
      end

      it "must be provided" do
        address.errors[field].should == [ "can't be blank" ]
      end
    end
  end
end
