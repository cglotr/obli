class AddCurrencyToObligations < ActiveRecord::Migration[5.1]
  def change
    add_column :obligations, :currency, :string
  end
end
