class Event < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :title
    validates :start_time
  end
end
