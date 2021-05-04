class Like < ApplicationRecord
  belongs_to :user
  belongs_to :practice

  validates_uniqueness_of :practice_id, scope: :user_id # 1組のみに絞る
end
