class CreateTableSettings < ActiveRecord::Migration
  def up
    create_table :table_settings do |t|
      t.integer  :goals,       default: 8
      t.integer  :advantages,  default: 2
      t.integer  :max_minutes, default: nil
      t.timestamps
    end
  end

  def down
    drop_table :matches
  end
end