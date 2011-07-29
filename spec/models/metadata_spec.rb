# encoding: utf-8
require "spec_helper"

describe Metadata do

  describe "#matches_on" do

    let!(:metadata) do
      Fabricate(:metadata)
    end

    context "when terms match" do

      let(:matches) do
        metadata.matches_on("Depeche Mode")
      end

      it "returns an array of matching terms" do
        matches.should == [ "Depeche Mode" ]
      end
    end

    context "when terms do not match" do

      let(:matches) do
        metadata.matches_on("Radiohead")
      end

      it "returns an empty array" do
        matches.should be_empty
      end
    end
  end

  describe ".search_for" do

    let!(:metadata) do
      Fabricate(:metadata)
    end

    context "when providing an exact match" do

      let(:results) do
        Metadata.search_for("Depeche Mode")
      end

      it "returns the matching entities" do
        results.should == [ metadata ]
      end
    end

    context "when providing a substring match" do

      context "when matching at the start" do

        let(:results) do
          Metadata.search_for("Depeche")
        end

        it "returns the matching entities" do
          results.should == [ metadata ]
        end
      end

      context "when matching in the middle" do

        let(:results) do
          Metadata.search_for("che M")
        end

        it "returns the matching entities" do
          results.should == [ metadata ]
        end
      end

      context "when matching in the end" do

        let(:results) do
          Metadata.search_for("Mode")
        end

        it "returns the matching entities" do
          results.should == [ metadata ]
        end
      end
    end

    context "when providing multiple terms" do

      context "when all terms match" do

        let(:results) do
          Metadata.search_for("piano synth")
        end

        it "returns the matching entities" do
          results.should == [ metadata ]
        end
      end

      context "when some terms match" do

        let(:results) do
          Metadata.search_for("piano synth bass")
        end

        it "returns the matching entities" do
          results.should == [ metadata ]
        end
      end

      context "when separating terms with a comma" do

        let(:results) do
          Metadata.search_for("piano, synth,bass")
        end

        it "returns the matching entities" do
          results.should == [ metadata ]
        end
      end
    end
  end
end
