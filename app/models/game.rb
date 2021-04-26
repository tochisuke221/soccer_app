class Game < ApplicationRecord

  belongs_to :user
  belongs_to :gametime
  belongs_to :gamenum
  belongs_to :level

  with_options presence: true do
    validates :gameday
    validates :location
    validates :title
    validates :check
  end

  with_options numericality: { other_than: 1 } do
    validates :gametime_id
    validates :gamenum_id
    validates :level_id
  end

end


