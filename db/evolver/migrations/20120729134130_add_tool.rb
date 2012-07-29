class AddTool
  include Evolver::Migration
  sessions :default

  def execute
    session[:bands].insert({ name: "Tool" })
  end

  def revert
    # Insert your code to revert the migration here.
  end
end
