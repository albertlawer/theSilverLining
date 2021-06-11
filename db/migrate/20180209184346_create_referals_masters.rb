class CreateReferalsMasters < ActiveRecord::Migration
  def change
    create_table :referals_masters do |t|
      t.integer :user_id
      t.integer :refered_user_id
      t.boolean :status

      t.timestamps null: false
    end
  end
end
