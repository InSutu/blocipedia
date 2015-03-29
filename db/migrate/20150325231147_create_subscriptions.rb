class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :sub_type
      t.string :stripe_id
      t.string :sub_id
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :users
  end
end
