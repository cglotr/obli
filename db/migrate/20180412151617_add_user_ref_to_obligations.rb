class AddUserRefToObligations < ActiveRecord::Migration[5.1]
  def change
    add_reference :obligations, :user, foreign_key: true
  end
end
