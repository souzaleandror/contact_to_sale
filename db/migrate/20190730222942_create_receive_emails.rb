class CreateReceiveEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :receive_emails do |t|
      t.string :name
      t.string :phone
      t.string :message
      t.string :vehicle
      t.string :price
      t.string :year
      t.string :link_vehicle
      t.string :brand_vehicle
      t.string :model_vehicle
      t.string :kilometer_vehicle
      t.string :accessories_vehicle

      t.timestamps
    end
  end
end
