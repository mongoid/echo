class MongoidWorker
  include Sidekiq::Worker

  def perform
    Band.each do |band|
      # do something here.
    end
  end
end
