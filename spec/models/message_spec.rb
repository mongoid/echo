# encoding: utf-8
require "spec_helper"

describe Message do

  describe "#create" do

    let(:message) do
      Message.create!
    end

    let(:report) do
      message.message_reports.create!
    end

    it "has fk on report same as pk on message" do
      report.message_id.should eq(message.message_id)
    end

    it "does not use _id on message fk" do
      report.message_id.should_not eq(message.id)
    end
  end

  describe "reloading from db" do

    let(:message) do
      Message.create!
    end

    let!(:report) do
      message.message_reports.create!
    end

    let(:from_db) do
      Message.find(message.id)
    end

    it "has all reports" do
      from_db.message_reports.should eq([report])
    end
  end
end
