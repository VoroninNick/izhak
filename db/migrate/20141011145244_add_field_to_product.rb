class AddFieldToProduct < ActiveRecord::Migration
  def change
    add_column :products, :slug, :string
    add_column :products, :description, :string
    add_column :products, :point, :integer
    add_column :products, :avatar_file_name, :string
    add_column :products, :avatar_file_size, :integer
    add_column :products, :avatar_content_type, :string
    add_column :products, :avatar_updated_at, :datetime
    add_column :products, :category_id, :integer
    add_index :products, :slug
  end
end
