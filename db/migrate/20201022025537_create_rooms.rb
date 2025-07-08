class CreateRooms < ActiveRecord::Migration[6.0]
  def change 
    create_table :rooms do |t|
      t.string :listing_name
      t.text :summary
      t.string :space_type
      t.string :desk_type
      t.integer :capacity
      t.string :noise_level
      t.integer :bath_room
      t.string :manager_on
      t.string :security_level
      t.string :address
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.boolean :is_wifi
      t.boolean :is_kitchen
      t.boolean :is_conference
      t.boolean :is_printing
      t.boolean :is_drinks
      t.boolean :is_air
      t.boolean :is_heating
      t.boolean :is_parking
      t.integer :price
      t.boolean :active
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

