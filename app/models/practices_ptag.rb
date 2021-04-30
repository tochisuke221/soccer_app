class PracticesPtag
  include ActiveModel::Model
  attr_accessor :title,:content,:category_id,:hardlevel_id,:user_id ,:name,:images,:practice_id,:ptag_id

  with_options presence: true do
    validates :title,length:{maximum:25}
    validates :content
    validates :name
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :hardlevel_id
  end

  def save(ptag_list)
    practice=Practice.create(title: title,content: content,category_id:category_id,hardlevel_id:hardlevel_id,user_id:user_id,images:images)
    #,区切りの配列をバラして1個づつPtagテーブルと中間テーブルに保存していくe
    
    ptag_list.each do |ptag_name|
    ptag = Ptag.where(name: ptag_name).first_or_initialize
    ptag.save
    PracticePtagRelation.create(practice_id:practice.id,ptag_id:ptag.id)
    end
  end

  def update(ptag_list)
    
    #practiceの更新
    @practice = Practice.where(id: practice_id)
    practice = @practice.update(title: title,content: content,category_id:category_id,hardlevel_id:hardlevel_id,user_id:user_id,images:images)
    @old_relations=PracticePtagRelation.where(practice_id:practice_id)
    #この時点で一旦中間テーブルのデータ消す
    @old_relations.each do |relation|
      relation.delete
    end  
    
    #ptagの更新
    ptag_list.each do |ptag_name|
      @ptag = Ptag.where(name: ptag_name).first_or_initialize
      @ptag.save
      #再度1個づつ中間テーブルへ登録
      new_relation=PracticePtagRelation.new(practice_id:practice_id,ptag_id:@ptag.id)
      new_relation.save
    end
  end
    #最後に更新した投稿とタグを結びつけ直
end
