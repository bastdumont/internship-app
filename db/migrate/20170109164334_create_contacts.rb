class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.integer :company_id
      t.text :email
      t.string :phone
      t.boolean :main_contact

      t.timestamps null: false
    end
  end
end
