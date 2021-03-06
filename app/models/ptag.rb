class Ptag < ApplicationRecord
  has_many :practice_tag_relations, dependent: :destroy
  has_many :practices, through: :practice_ptag_relations

  validates :name, uniqueness: { case_sensitive: true }
end
