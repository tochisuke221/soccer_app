class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :career
  # 投稿機能
  has_many :practices, dependent: :destroy
  has_many :pcomments, dependent: :destroy
  # いいね機能
  has_many :likes, dependent: :destroy
  has_many :liked_practices, through: :likes, source: :practice
  has_one_attached :myphoto
  # フォロー（こっち）側役
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow # 架空モデル
  # フォロワー（あっち）側役
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy # 架空モデル
  has_many :followers, through: :reverse_of_relationships, source: :user # 架空モデル
  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  # チャット機能
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_messages, dependent: :destroy
  # 試合募集
  has_many :games, dependent: :destroy
  belongs_to :gamenum
  belongs_to :gametime
  belongs_to :level
  # カレンダー機能
  has_many :events, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :name, length: { maximum: 9 }
    validates :team_name, length: { maximum: 20 }
    validates :phone_num, format: { with: /\A\d{11}\z/ }
  end

  with_options numericality: { other_than: 1 } do
    validates :career_id
  end

  # いいね機能
  def already_liked?(practice)
    likes.exists?(practice_id: practice.id)
  end

  # フォロー&フォロワー機能

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  # フォローしているかしてないかの有無をそもそもこれで調べたいから作成
  def following?(other_user)
    followings.include?(other_user)
  end

  # 通知機能

  # 自分が誰かををフォローしたときに、通知作成
  def create_notification_follow!(current_user)
    temp = Notification.where(['visiter_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow']) # プレースホルダーで記載した
    if temp.blank? # まだ登録されてないなら登録（通知）
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲスト'
      user.team_name = 'ゲスト高校'
      user.phone_num = '09012341234'
      user.career_id = 2
    end
  end
end
