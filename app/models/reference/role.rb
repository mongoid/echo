# encoding: utf-8
module Reference
  class Role
    include Mongoid::Document

    TYPES = [ :administrator, :artist, :producer, :subscriber, :visitor ]

    field :name, type: String
    field :actions, type: Hash, default: {}

    # Name of a role must be present and unique, since there can only be one of
    # every role.
    validates :name, presence: true, uniqueness: true

    index({ name: 1 }, { background: true })

    TYPES.each do |name|

      # Get all the roles for the application for this name.
      #
      # @example Get the administrators.
      #   Reference::Role.administrators
      #
      # @example Get the artists.
      #   Reference::Role.artists
      #
      # @example Get the producers.
      #   Reference::Role.producers
      #
      # @example Get the subscribers.
      #   Reference::Role.subscribers
      #
      # @example Get the visitors.
      #   Reference::Role.visitors
      #
      # @return [ Array<Reference::Role> ] The matching roles.
      scope "#{name}s", ->{ where(name: name) }

      # Since there is only one of each role, this provides a convenience for
      # getting the only role for the provided name.
      #
      # @example Get the administrator role.
      #   Role.administrator
      #
      # @example Get the artist role.
      #   Role.artist
      #
      # @example Get the producer role.
      #   Role.producer
      #
      # @example Get the subscriber role.
      #   Role.subscriber
      #
      # @example Get the visitor role.
      #   Role.visitor
      #
      # @return [ Role ] The matching role.
      (class << self; self; end).class_eval <<-EOM
        def #{name}
          #{name}s.first
        end
      EOM
    end

    # This class represents role reference data but for optimizations on
    # database queries we can easily denormalize it into an embedded document
    # on the user. This generates that role for us.
    #
    # @example Generate a denormalized embedded role.
    #   role.denormalized
    #
    # @return [ ::Role ] The denormalized role.
    def denormalized
      ::Role.new(name: name, actions: actions, role: self)
    end
  end
end
