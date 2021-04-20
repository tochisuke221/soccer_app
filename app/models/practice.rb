class Practice < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :pcomments,dependent: :destroy
  has_many :likes,dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :practice_ptag_relations
  has_many :ptags, through: :practice_ptag_relations
  
  belongs_to :user
  belongs_to :hardlevel
  belongs_to :category
  belongs_to :career
  has_many_attached :images
  
  with_options presence: true do
    validates :user_id
    validates :title
    validates :content
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :hardlevel_id
  end

  def self.search(search)
    if search != ""
      Practice.where('title LIKE(?)', "%#{search}%")
    else
      Practice.all
    end
  end


end
