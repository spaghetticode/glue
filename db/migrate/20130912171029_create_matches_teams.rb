class CreateMatchesTeams < ActiveRecord::Migration
  def change
    create_table :matches_teams do |t|
      t.references :match
      t.references :team
    end
  end
end
