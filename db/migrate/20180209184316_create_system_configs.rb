class CreateSystemConfigs < ActiveRecord::Migration
  def change
    create_table :system_configs do |t|
      t.string :name
      t.string :desc
      t.decimal :value, precision: 12, scale: 2
      t.boolean :status

      t.timestamps null: false
    end
  end
end
