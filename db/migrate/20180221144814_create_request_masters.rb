class CreateRequestMasters < ActiveRecord::Migration
  def change
    create_table :request_masters do |t|
      t.integer :user_id
      t.string :customer_number
      t.string :network
      t.string :trans_type
      t.string :voucher_code
      t.string :item_desc
      t.string :trans_id
      t.decimal :amount, precision: 12, scale: 2
      t.decimal :total_amount, precision: 12, scale: 2
      t.boolean :status
      t.boolean :callback_status
      t.string :resp_code
      t.string :resp_desc

      t.timestamps null: false
    end
  end
end
