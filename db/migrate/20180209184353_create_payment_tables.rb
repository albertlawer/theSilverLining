class CreatePaymentTables < ActiveRecord::Migration
  def change
    create_table :payment_tables do |t|
      t.integer :user_id
      t.integer :referer_user_id
      t.string :investment_master_code
      t.decimal :client_profit, precision: 12, scale: 2
      t.decimal :referer_profit, precision: 12, scale: 2
      t.decimal :admin_profit, precision: 12, scale: 2
      t.boolean :status

      t.timestamps null: false
    end
  end
end
