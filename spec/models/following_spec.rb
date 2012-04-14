# encoding: utf-8
require "spec_helper"

describe Following do

  describe ".ranked" do

    let!(:dead_kennedys) do
      Fabricate(:band, name: "Dead Kennedys")
    end

    let!(:clash) do
      Fabricate(:band, name: "The Clash")
    end

    let!(:ramones) do
      Fabricate(:band, name: "Ramones")
    end

    let!(:durran) do
      Fabricate(:subscriber, email: "durran@gmail.com")
    end

    let!(:moses) do
      Fabricate(:subscriber, email: "mosesschneider@gmx.net")
    end

    before do
      durran.follow(dead_kennedys)
      durran.follow(clash)
      moses.follow(clash)
    end

    it "returns the bands ranked by number of followings", service: :following do
      Following.ranked.should ==
        [
          { "value" => { "followers" => 1.0 }, "_id" => dead_kennedys.id },
          { "value" => { "followers" => 2.0 }, "_id" => clash.id }
        ]
    end
  end
end
