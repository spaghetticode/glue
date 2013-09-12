class CreatePlayersTeams < ActiveRecord::Migration
  def change
    create_table :players_teams do |t|
      t.references :player
      t.references :team
      t.timestamps
    end
  end
end
