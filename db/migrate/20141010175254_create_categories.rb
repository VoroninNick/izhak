class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.belongs_to :restoran

      t.timestamps
    end
    add_index :categories, :slug
  end
end
