# encoding: utf-8
class HomeController < ApplicationController
  def index
    db = Band.mongo_session.options[:database]
    render json: {ping: "OK", host: @current_site.host, current_db: db, before_db: @first_db}
  end
end
