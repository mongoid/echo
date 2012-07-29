class AddDm
  include Evolver::Migration
  sessions :default

  def execute
    session[:bands].insert({ name: "Depeche Mode" })
  end

  def revert
    # Insert your code to revert the migration here.
  end
end
