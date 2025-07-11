class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :color, null: false, default: 'blue'

      t.timestamps
    end
  end
end
