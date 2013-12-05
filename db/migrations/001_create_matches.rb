class CreateMatches < ActiveRecord::Migration
  def up
    create_table :matches do |t|
      t.string   :player_1, :player_2, :player_3, :player_4
      t.integer  :team_a_score, default: 0
      t.integer  :team_b_score, default: 0
      t.datetime :start_at, :end_at
      t.timestamps
    end
  end

  def down
    drop_table :matches
  end
end