class PracticesPtag
  include ActiveModel::Model
  attr_accessor :title,:content,:category_id,:hardlevel_id,:user_id ,:name

  with_options presence: true do
    validates :user_id
    validates :title
    validates :content
    validates :name
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :hardlevel_id
  end

  def save
    practice=Practice.create(title: title,content: content,category_id:category_id,hardlevel_id:hardlevel_id,user_id:user_id)
    ptag = Ptag.create(name: name)

    PracticePtagRelation.create(practice_id:practice.id,ptag_id:ptag.id)
  end

    
end
