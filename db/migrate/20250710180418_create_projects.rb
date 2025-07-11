class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, default: 0
      t.datetime :deleted_at, null: true, default: nil

      t.timestamps
    end
  end
end
