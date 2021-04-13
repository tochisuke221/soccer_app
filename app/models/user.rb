class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_one_attached :myphoto
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
end
