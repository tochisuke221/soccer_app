class Hardlevel < ActiveHash::Base
  self.data = [
    { id: 1, name:  '---' },
    { id: 2, name:  '天国モード' },
    { id: 3, name:  '比較的低い' },
    { id: 4, name:  '普通' },
    { id: 5, name:  '比較的高い' },
    { id: 6, name:  '相当高い' },
    { id: 7, name:  '地獄モード' }
  ]
  include ActiveHash::Associations
  has_many :practices
end
