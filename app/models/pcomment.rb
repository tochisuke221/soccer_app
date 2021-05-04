class Pcomment < ApplicationRecord
  belongs_to :practice
  belongs_to :user

  with_options presence: true do
    validates :comment
  end
end
