class Category < ActiveRecord::Base
  attr_accessible :name, :slug, :restoran, :restoran_id
  belongs_to :restoran
  has_many :products

  accepts_nested_attributes_for :products

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :restoran, presence: true

end
