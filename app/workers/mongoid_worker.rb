# encoding: utf-8
class MongoidWorker
  include Sidekiq::Worker

  # Perform a long running process with Sidekiq.
  def perform
    Band.each do |band|
      # do something here.
    end
  end
end
