class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.references :obligation, foreign_key: true

      t.timestamps
    end
  end
end
