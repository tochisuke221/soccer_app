class Gamenum < ActiveHash::Base
  self.data = [
    { id: 1, name:  '---' },
    { id: 2, name:  '1試合×1本' },
    { id: 3, name:  '1試合×2本' },
    { id: 4, name:  '1試合×3本' },
    { id: 5, name:  '1試合×4本' },
    { id: 6, name:  '1試合×5本' }
    { id: 7, name:  'その他' }
  ]
  include ActiveHash::Associations
  has_many :games
end
