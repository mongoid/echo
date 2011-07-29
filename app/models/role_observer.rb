# encoding: utf-8
class RoleObserver < Mongoid::Observer

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
end
