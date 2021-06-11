class CreateInvestmentMasters < ActiveRecord::Migration
  def change
    create_table :investment_masters do |t|
      t.integer :user_id
      t.decimal :amount_invested, precision: 12, scale: 2
      t.string :transaction_code
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :client_per, precision: 5, scale: 2
      t.decimal :ref_per, precision: 5, scale: 2
      t.boolean :status

      t.timestamps null: false
    end
  end
end
