class Practice < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :hardlevel
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

end
