class Game < ApplicationRecord

  belongs_to :user

  with_options presence: true do
    validates :gameday
    validates :location
    validates :gametime_id
    validates :gamenum_id
    validates :gametime_id
    validates :level_id
    validates :title
    validates :check
  end
end


