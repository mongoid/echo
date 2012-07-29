require "spec_helper"

describe FollowingObserver do

  describe "#after_create" do

    let(:observer) do
      FollowingObserver.instance
    end

    let(:depeche_mode) do
      Fabricate.build(:band, name: "Depeche Mode")
    end

    let(:durran) do
      Fabricate.build(:subscriber, email: "durran@gmail.com")
    end

    let(:following) do
      Fabricate.build(:following, user: durran, band: depeche_mode)
    end

    context "when the settings allow facebook notification" do

      before do
        durran.settings = Fabricate.build(:facebook_notifiable_settings)
      end

      it "tweets the following" do
        Facebook.should_receive(:post_to_wall).with(following).and_return(true)
        observer.after_create(following)
      end
    end

    context "when the settings allow twitter notification" do

      before do
        durran.settings = Fabricate.build(:twitter_notifiable_settings)
      end

      it "posts to the users facebook wall" do
        Twitter.should_receive(:tweet).with(following).and_return(true)
        observer.after_create(following)
      end
    end
  end
end
