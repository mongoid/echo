# encoding: utf-8
class Settings
  include Mongoid::Document

  field :facebook_notifiable, type: Boolean
  field :twitter_notifiable, type: Boolean

  embedded_in :user
end
