class Obligation < ApplicationRecord
  has_many :payments
  validates :title, presence: true
end
