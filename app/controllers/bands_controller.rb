# encoding: utf-8
class BandsController < ApplicationController
  respond_to :json

  expose(:bands)

  def index
    respond_with bands
  end
end
