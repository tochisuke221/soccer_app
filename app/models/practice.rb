class Practice < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :pcomments,dependent: :destroy
  has_many :likes,dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :user
  belongs_to :hardlevel
  belongs_to :category
  belongs_to :career
  has_one_attached :image
  
  with_options presence: true do
    validates :user_id
    validates :title
    validates :content
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :hardlevel_id
  end

end
