class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_site, :check_site, :override_db
  after_filter :reset_db

  def current_site
    @first_db = Band.mongo_session.options[:database]

    # currently i hard coded with(database: "ecosystem-admin") to
    # fix the problem
    server_name = ['m1', 'm2', 'm3'].sample
    @current_site ||= Site.where(host: server_name).first
  end

  def require_site
    unless current_site
      #      render file: '/shared/not_found'
      render status: :not_found, nothing: true
    end
  end

  def check_site
    unless current_site.online?
      #      render file: '/shared/offline'
      render status: :bad_request, nothing: true
    end
  end

  def override_db
    Mongoid.override_database current_site.db_name
  end

  def reset_db
    Mongoid.override_database nil
  end
end
