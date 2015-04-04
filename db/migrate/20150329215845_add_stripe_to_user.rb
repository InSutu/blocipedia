class AddStripeToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :stripe_plan_id, :string
    add_column :users, :sub_type, :string
  end
end
