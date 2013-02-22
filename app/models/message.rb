class Message
  include Mongoid::Document

  field :message_id, :default => proc { "fail-#{Time.now.to_f.to_s}" }
  has_many :message_reports, primary_key: :message_id, foreign_key: :message_id
end
