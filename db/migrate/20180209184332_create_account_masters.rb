class CreateAccountMasters < ActiveRecord::Migration
  def change
    create_table :account_masters do |t|
      t.integer :user_id
      t.decimal :avaliable_balance, precision: 12, scale: 2
      t.boolean :status

      t.timestamps null: false
    end
  end
end
