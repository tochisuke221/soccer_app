class Game < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user
 
  belongs_to :gamenum
  belongs_to :gametime
  belongs_to :level

  with_options presence: true do
    validates :gameday
    validates :location,length:{maximum:30}
    validates :title,length:{maximum:40}
  end

  with_options numericality: { other_than: 1 } do
    validates :gametime_id
    validates :gamenum_id
    validates :level_id
  end

end


