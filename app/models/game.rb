class Game < ApplicationRecord

  belongs_to :user
  belongs_to :gametime
  belongs_to :gamenum
  belongs_to :level

  with_options presence: true do
    validates :gameday
    validates :location
    validates :gametime_id
    validates :gamenum_id
    validates :level_id
    validates :title
    validates :check
  end
end


