class AddListIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :list_id, :string
  end
end
