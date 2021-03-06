# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.references :obligation, foreign_key: true

      t.timestamps
    end
  end
end
