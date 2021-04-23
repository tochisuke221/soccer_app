class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :practices,dependent: :destroy
  has_many :pcomments,dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_practices, through: :likes, source: :practice
  has_one_attached :myphoto

  #フォロー（こっち）側役
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow #架空モデル
  #フォロワー（あっち）側役
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy #架空モデル
  has_many :followers, through: :reverse_of_relationships, source: :user #架空モデル

  has_many :active_notifications,class_name: "Notification",foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  belongs_to :career
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  with_options presence: true do
    validates :name
    validates :team_name
    validates :phone_num, format: { with: /\A\d{11}\z/ }
  end

  with_options numericality: { other_than: 1 } do
    validates :career_id
  end

  #いいね機能
  def already_liked?(practice)
    self.likes.exists?(practice_id: practice.id)
  end

 #フォロー&フォロワー機能

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)# フォローしているかしてないかの有無をそもそもこれで調べたいから作成
    self.followings.include?(other_user)
  end

  #通知機能

  def create_notification_follow!(current_user)#自分が誰かををフォローしたときに、通知作成
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])#プレースホルダーで記載した
    if temp.blank?#まだ登録されてないなら登録（通知）
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  #ゲストログイン機能
  def self.guest
    find_or_create_by!(email:'guest@example.com') do |user|
      user.password=SecureRandom.urlsafe_base64
      user.name="ゲスト"
      user.team_name="ゲスト高校"
      user.phone_num="09012341234"
      user.career_id= 2
    end
  end
  
end
