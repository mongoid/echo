# encoding: utf-8
require "spec_helper"

describe BandObserver do

  let(:observer) do
    BandObserver.instance
  end

  describe "#after_create" do

    let(:band) do
      Fabricate.build(:band)
    end

    before do
      observer.after_create(band)
    end

    let(:metadata) do
      Metadata.search_for(band.name)
    end

    it "creates an metadata for the band name" do
      metadata.first.tags.should include(band.name)
    end
  end

  describe "#after_update" do

    let!(:band) do
      Fabricate(:band)
    end

    context "when the band name has changed" do

      before do
        band.name = "Moderat"
        observer.after_update(band)
      end

      let!(:metadata) do
        Metadata.search_for("Moderat")
      end

      it "updates the band name metadata" do
        metadata.first.tags.should include("Moderat")
      end

      it "does not create a new metadata entry" do
        Metadata.count.should == 1
      end
    end
  end
end
