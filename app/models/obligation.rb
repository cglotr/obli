class Obligation < ApplicationRecord
  has_many :payments, dependent: :destroy
  validates :title, presence: true
end
