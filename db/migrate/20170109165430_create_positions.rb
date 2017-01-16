class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.string :area_of_interest
      t.text :link
      t.string :city
      t.integer :company_id
      t.integer :contact_id
      t.integer :capacity
      t.string :allowance
      t.boolean :hiring_opportunity
      t.text :description
      t.text :requirements
      t.text :remarks
      t.string :status
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
