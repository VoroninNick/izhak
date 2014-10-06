class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :is_approved
      t.belongs_to :user, index: true
      t.float :total_price
      t.text :comment

      t.timestamps
    end
  end
end
