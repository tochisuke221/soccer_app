class Game < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user
 
  belongs_to :gamenum
  belongs_to :level

  with_options presence: true do
    validates :gameday
    validates :location
    validates :title
  end

  with_options numericality: { other_than: 1 } do
    validates :gametime_id
    validates :gamenum_id
    validates :level_id
  end

end


