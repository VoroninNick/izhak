class Order < ActiveRecord::Base
  attr_accessible :is_approved, :user_id, :user, :total_price, :comment, :products

  after_initialize :set_default_status, :if => :new_record?

  def set_default_status
    self.is_approved ||= false
  end

  belongs_to :user
  has_and_belongs_to_many :products, join_table: 'product_orders'

  accepts_nested_attributes_for :products

  # TODO: Think about validation of products presence
  #validates :products, presence: true
  default_scope { order('created_at DESC') }
end
