class CreateRestorans < ActiveRecord::Migration
  def change
    create_table :restorans do |t|
      t.string :name

      t.timestamps
    end
  end
end
