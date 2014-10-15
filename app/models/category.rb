require 'unicode'

class Category < ActiveRecord::Base
  attr_accessible :name, :slug, :restoran, :restoran_id
  before_validation :friendly_url
  before_save :normalize_name

  belongs_to :restoran
  has_many :products

  accepts_nested_attributes_for :products

  validates :name, presence: true
  validates :slug, uniqueness: true
  validates :restoran, presence: true

  default_scope { order('created_at ASC') }


  def to_param
    slug
  end

  def friendly_url
    self.slug = [restoran_id, name.parameterize].join("-")
  end

  def normalize_name
    self.name = Unicode::capitalize(name)
  end






end
