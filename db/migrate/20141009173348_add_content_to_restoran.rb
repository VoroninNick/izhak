class AddContentToRestoran < ActiveRecord::Migration
  def change
    add_column :restorans, :slug, :string
    add_index :restorans, :slug
    add_column :restorans, :content, :text
  end
end
