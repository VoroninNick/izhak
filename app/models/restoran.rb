class Restoran < ActiveRecord::Base
  attr_accessible :name, :slug, :content, :avatar

  has_attached_file :avatar, styles:{
                               thumb: '120x120#'
                           },
                    url:'/assets/images/restorans/:class/:id/image_:style.:extension',
                    path:':rails_root/public:url'

  validates_attachment :avatar, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/svg+xml'] }

  has_many :categories

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  default_scope { order('created_at DESC') }

  def to_param
    slug
  end

  def friendly_url
    self.slug = name.parameterize
  end

end
