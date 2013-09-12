class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :winner, index: true
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
