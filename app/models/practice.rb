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

  def self.search(keyword)
    if keyword != ""
      split_keyword = keyword.split(/[[:blank:]]+/)

      @practices = [] 
      split_keyword.each do |keyword|
        next if keyword == "" 
        @practices += Practice.where('title LIKE(?)', "%#{keyword}%")
      end 
      @practices.uniq! #重複した商品を削除する
    else
      Practice.all
    end
  end

end
