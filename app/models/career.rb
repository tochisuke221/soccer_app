class Career < ActiveHash::Base
  self.data = [
    { id: 1, name:  '---' },
    { id: 2, name:  '1年目〜3年目' },
    { id: 3, name:  '4年目〜6年目' },
    { id: 4, name:  '7年目〜9年目' },
    { id: 5, name:  '10年目〜' },
  ]
  include ActiveHash::Associations
  has_many :users
end
