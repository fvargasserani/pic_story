class ChangeUserIdToBeStringStories < ActiveRecord::Migration[6.0]
  def change
    change_column :stories, :user_id, :string
  end
end
