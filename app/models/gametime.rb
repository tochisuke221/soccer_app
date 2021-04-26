class Gametime < ActiveHash::Base
  self.data = [
    { id: 1, name:  '---' },
    { id: 2, name:  '20分ハーフ' },
    { id: 3, name:  '30分ハーフ' },
    { id: 4, name:  '35分ハーフ' },
    { id: 5, name:  '40分ハーフ' },
    { id: 6, name:  '45分ハーフ' },
    { id: 7, name:  'その他' }
  ]
  include ActiveHash::Associations
  has_many :game
end
