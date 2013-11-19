class ChangeMatches < ActiveRecord::Migration
  def change
    add_column :matches, :team_a_id, :integer
    add_column :matches, :team_b_id, :integer
    add_column :matches, :team_a_score, :integer, :default => 0
    add_column :matches, :team_b_score, :integer, :default => 0

    drop_table :matches_teams
  end
end
