class Category < ActiveHash::Base
  self.data = [
    { id: 1, name:  '---' },
    { id: 2, name:  '個人技トレーニング' },
    { id: 3, name:  'グループ戦術（2〜4人）' },
    { id: 4, name:  'チーム戦術（5人以上）' },
    { id: 5, name:  'フィジカルトレーニング' },
    { id: 6, name:  'メンタルトレーニング' },
    { id: 7, name:  '食育トレーニング' },
    { id: 8, name:  'その他' }
  ]
  include ActiveHash::Associations
  has_many :practices
end
