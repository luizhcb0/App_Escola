class School < ApplicationRecord
  belongs_to :user, dependent: :destroy

end
