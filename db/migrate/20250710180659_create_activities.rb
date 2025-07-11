class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.string :content, null: false
      t.string :type, null: false
      t.references :activity, foreign_key: false, null: true
      t.references :activitable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.datetime :deleted_at, null: true, default: nil

      t.timestamps
    end
  end
end
