class Practice < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :pcomments,dependent: :destroy
  has_many :likes,dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :practice_ptag_relations,dependent: :destroy
  has_many :ptags, through: :practice_ptag_relations

  has_many :notifications,dependent: :destroy
  
  belongs_to :user
  belongs_to :hardlevel
  belongs_to :category
  belongs_to :career
  has_many_attached :images
  
  with_options presence: true do
    validates :title
    validates :content
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :hardlevel_id
  end

  def self.search(keyword) # クラスメソッド,キーワードをもらって検索し、ヒットしたものを返す
    if keyword != ""
      split_keyword = keyword.split(/[[:blank:]]+/)
      @practices = [] 
      split_keyword.each do |keyword|
        next if keyword == "" 
        @practices += Practice.where('title LIKE(?)', "%#{keyword}%")
      end 
      return @practices.uniq #重複した商品を削除する
    end
  end


  #通知機能（コメントといいね）
  
  def create_notification_by(current_user)#自分がいいねしたときに、いいねした投稿、通知先、いいねしたというアクションを保存
    notification = current_user.active_notifications.new(practice_id:id,visited_id:user_id,action:"like")
    notification.save if notification.valid?
  end

 
  def create_notification_comment!(current_user, pcomment_id, visited_id)
    #ある投稿に、あるコメントをしたユーザを登録する
    notification = current_user.active_notifications.new(
      practice_id: id,
      pcomment_id: pcomment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとして通知が来ないようにする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
 end

end
