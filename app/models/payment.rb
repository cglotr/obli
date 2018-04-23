# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :obligation
  validates :amount, presence: true
end
