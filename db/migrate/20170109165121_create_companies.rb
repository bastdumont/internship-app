class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :area_of_interest
      t.text :description
      t.string :status
      t.text :website
      t.string :city
      t.text :notes
      t.text :adress

      t.timestamps null: false
    end
  end
end
