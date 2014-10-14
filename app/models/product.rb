class Product < ActiveRecord::Base

  attr_accessible :name, :slug, :price, :description, :point, :avatar, :category, :category_id, :category_attributes

  has_and_belongs_to_many :orders, join_table: 'product_orders'
  belongs_to :category

  before_validation :friendly_url

  validates :name, presence: true
  validates :slug, uniqueness: true
  validates :price, presence: true
  validates :description, presence: true
  validates :point, presence: true
  #validates :avatar, presence: true
  #validates :category, presence: true

  has_attached_file :avatar, styles:{
                               thumb: '60x60#',
                               thumb_pr: '120x120#',
                               main: '238x238#'
                           },
                    url:'/assets/images/food/:class/:id/image_:style.:extension',
                    path:':rails_root/public:url'

  validates_attachment :avatar, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/svg+xml'] }

  accepts_nested_attributes_for :category

  def to_param
    slug
  end

  def friendly_url
    self.slug = [category_id, price, name.parameterize].join("-")
  end

end
