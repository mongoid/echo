# encoding: utf-8
class Role
  include Mongoid::Document

  field :name, type: String
  field :actions, type: Hash, default: {}

  belongs_to :role, class_name: "Reference::Role"

  embedded_in :user

  delegate :band, to: :user

  # When creating a new embedded role, we need to iterate through the actions
  # and switch out the document specific permissions with the id of the
  # appropriate object.
  #
  # @example Execute the before callback.
  #   observer.before_create(role)
  #
  # @param [ Role ] role The role of the user.
  def before_create(role)
    actions = role.actions
    actions.each_pair do |action, value|
      if value == :id
        actions[action] = role.send(action[action.index("-") + 1, action.length]).id
      end
    end
  end

  Reference::Role::TYPES.each do |role|

    # Check if the role is one of the predefined types.
    #
    # @example Is the role an admin?
    #   role.administrator?
    #
    # @example Is the role an artist?
    #   role.artist?
    #
    # @example Is the role a producer?
    #   role.producer?
    #
    # @example Is the role a subscriber?
    #   role.subscriber?
    #
    # @example Is the role a visitor?
    #   role.visitor?
    #
    # @return [ true, false ] If the role is of the expected type.
    define_method("#{role}?") { name == role.to_s }
  end

  # Does the role have the ability to perform the supplied action?
  #
  # @example Can the role act?
  #   role.able_to?("manage.roles")
  #
  # @param [ String ] action The action to check.
  # @param [ Document ] doc The document to check against.
  #
  # @return [ true, false ] If the role can act.
  def able_to?(action, doc = nil)
    permitted = actions[action]
    doc ? permitted == :all || permitted == doc.id : permitted.present?
  end
end
