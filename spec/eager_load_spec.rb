require "spec_helper"

describe "EagerLoad" do

  def expect_to_receive_query(number)
    events = []

    subscriber = ActiveSupport::Notifications.subscribe('query.moped') do |*args|
      events << ActiveSupport::Notifications::Event.new(*args)
    end
    yield
    expect(events.length).to(eq(number), %Q[
Expected to receive #{number} queries, it received
#{events.map { |e| e.payload[:ops].map(&:log_inspect) }.join("\n")} ])
  ensure
    ActiveSupport::Notifications.unsubscribe(subscriber)
  end

  describe "eager load" do

    before do
      band = Fabricate(:depeche_mode)
      3.times { |i| band.members << Fabricate(:user, email: "band1_#{i}@g.com", cat: Pet.new) }
      band = Fabricate(:band)
      2.times { |i| band.members << Fabricate(:user, email: "band2_#{i}@g.com", cat: Pet.new) }
      band = Fabricate(:band, name: 'foo')
      band.members << Fabricate(:user, email: "foo@g.com", cat: Pet.new)

    end

    it "loads all has_many" do

      expect_to_receive_query(2) do
        bands = Band.all.includes(:members).to_a
        expect(bands.map { |b| b.members }.flatten.size).to eq(6)
      end
    end

    it "loads all belongs_to" do

      expect_to_receive_query(2) do
        users = User.all.includes(:band).to_a
        expect(users.map { |u| u.band }.flatten.uniq.size).to eq(3)
      end
    end

    it "loads all has_one" do

      expect_to_receive_query(2) do
        users = User.all.includes(:cat).to_a
        expect(users.map(&:cat).flatten.size).to eq(6)

        users.first.cat
        users.last.cat
      end
    end

    it "loads has_one and belongs_to" do
      expect_to_receive_query(3) do
        User.all.includes(:band, :cat).each do |user|
          expect(user.cat).to_not be_nil
          expect(user.band).to_not be_nil
        end
      end
    end
  end
end
