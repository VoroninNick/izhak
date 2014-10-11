class AddAvatarToRestoran < ActiveRecord::Migration
  def change
    add_column :restorans, :avatar_file_name, :string
    add_column :restorans, :avatar_file_size, :integer
    add_column :restorans, :avatar_content_type, :string
    add_column :restorans, :avatar_updated_at, :datetime
  end
end
