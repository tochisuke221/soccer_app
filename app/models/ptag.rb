class Ptag < ApplicationRecord
has_many :practice_tag_relations
has_many ::practice
end