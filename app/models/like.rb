class Like < ApplicationRecord


  belongs_to :user
  belongs_to :practice

  with_options presence:true do
    validates :user
    validates :practice
  end

  validates_uniqueness_of :practice_id, scope: :user_id #1組のみに絞る
end
