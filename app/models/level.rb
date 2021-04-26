class Level < ActiveHash::Base
  self.data = [
    { id: 1, name:  '---' },
    { id: 2, name:  'レベルは問わない' },
    { id: 3, name:  '地区大会初戦〜3回戦レベル' },
    { id: 4, name:  '地区大会上位レベル' },
    { id: 5, name:  '県大会1回戦〜2回戦' },
    { id: 6, name:  '県大会3回戦〜4回戦' },
    { id: 7, name:  'それ以上（※強豪・名門校を求めます）' }
  ]
  include ActiveHash::Associations
  has_many :game
end
