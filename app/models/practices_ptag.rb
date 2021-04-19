class PracticesPtag
  include ActiveModel::Model
  attr_accessor :title,:content,:category_id,:hardlevel_id,:user_id ,:name,:images,:practice_id,:ptag_id

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
    practice=Practice.create(title: title,content: content,category_id:category_id,hardlevel_id:hardlevel_id,user_id:user_id,images:images)
    ptag = Ptag.where(name: name).first_or_initialize
    ptag.save

    PracticePtagRelation.create(practice_id:practice.id,ptag_id:ptag.id)
  end

  def update
    @practice = Practice.where(id: practice_id)
    practice = @practice.update(title: title,content: content,category_id:category_id,hardlevel_id:hardlevel_id,user_id:user_id,images:images)
    ptag = Ptag.where(name: name).first_or_initialize
    ptag.save

    # 更新したpostとtagを紐付け、中間テーブルを更新する
    map = PracticePtagRelation.where(practice_id: practice_id )
    map.update(practice_id: practice_id, ptag_id: ptag.id)
  end

    
end
