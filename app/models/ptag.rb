class Ptag < ApplicationRecord
has_many :practice_tag_relations
has_many :practices, through: :practice_ptag_relations
end
