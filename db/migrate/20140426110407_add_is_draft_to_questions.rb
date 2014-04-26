class AddIsDraftToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :is_draft, :boolean, default: false
  end
end
