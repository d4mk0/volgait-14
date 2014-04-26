class AddIsSolvedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :is_solved, :boolean, default: false
  end
end
