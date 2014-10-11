class Product < ActiveRecord::Base

  attr_accessible :name, :slug, :price, :description, :point, :avatar, :category, :category_id, :category_attributes

  has_and_belongs_to_many :orders, join_table: 'product_orders'
  belongs_to :category

  before_validation :friendly_url

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  accepts_nested_attributes_for :category

  def to_param
    slug
  end

  def friendly_url
    self.slug = name.parameterize
  end

end
