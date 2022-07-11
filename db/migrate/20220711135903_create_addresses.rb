class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :zipcode
      t.string :town
      t.string :country
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
