class AddPlacebo
  include Evolver::Migration
  sessions :default

  def execute
    session[:bands].insert({ name: "Placebo" })
  end

  def revert
    # Insert your code to revert the migration here.
  end
end
