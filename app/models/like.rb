class Like < ApplicationRecord


  belongs_to :user
  belongs_to :practice

  with_options presence:true do
    validates :user
    validates :practice
  end
end
