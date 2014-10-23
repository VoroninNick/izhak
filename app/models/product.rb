# coding: utf-8
require 'unicode'

class Product < ActiveRecord::Base

  attr_accessible :name, :slug, :price, :description, :point, :avatar, :category, :category_id, :category_attributes, :unit

  has_and_belongs_to_many :orders, join_table: 'product_orders'
  belongs_to :category

  before_validation :friendly_url
  before_save :normalize_name

  default_scope { order('created_at DESC') }
  scope :asc, -> { order('created_at ASC') }

  validates :name, presence: true
  validates :slug, uniqueness: true
  validates :price, presence: true
  #validates :description, presence: true
  #validates :point, presence: true
  #validates :avatar, presence: true
  #validates :category, presence: true

  has_attached_file :avatar, styles:{
                               thumb: '60x60#',
                               thumb_pr: '120x120#',
                               main: '238x238#',
                               main_big: '682x320#',
                               main_big_square: '1024x820#'
                           },
                    convert_options:{
                        thumb: '-quality 80 -interlace Plane',
                        thumb_pr: '-quality 80 -interlace Plane',
                        main: '-quality 80 -interlace Plane',
                        main_big: '-quality 80 -interlace Plane',
                        main_big_square: '-quality 80 -interlace Plane'
                    },
                    default_url: "/assets/images/food/:style/missing.jpg",
                    url:'/assets/images/food/:class/:id/image_:style.:extension',
                    path:':rails_root/public:url'

  validates_attachment :avatar, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/svg+xml'] }

  accepts_nested_attributes_for :category

  def to_param
    slug
  end

  def image_slug
    return name.parameterize if name
    "unknown"
  end

  def friendly_url
    self.slug = [(category.name).parameterize, (price.to_s).parameterize, name.parameterize].join("-")
  end

  def normalize_name
    self.name = Unicode::capitalize(name)
  end

  def percent_of(n)
    self.to_f / n.to_f * 10.0
  end

  def ceil2(exp = 0)
    multiplier = 10 ** exp
    ((self * multiplier).ceil).to_f/multiplier.to_f
  end

  def calculate_points
    self.point = (percent_of(price)).round
  end

end
