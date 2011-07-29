# encoding: utf-8
Fabricator(:settings) do
  facebook_notifiable false
  twitter_notifiable false
end

Fabricator(:facebook_notifiable_settings, from: :settings) do
  facebook_notifiable true
end

Fabricator(:twitter_notifiable_settings, from: :settings) do
  twitter_notifiable true
end
