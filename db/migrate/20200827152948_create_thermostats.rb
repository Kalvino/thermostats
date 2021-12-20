class CreateThermostats < ActiveRecord::Migration[6.0]
  def change
    create_table :thermostats do |t|
      t.string :household_token
      t.string :location

      t.timestamps
    end
  end
end
