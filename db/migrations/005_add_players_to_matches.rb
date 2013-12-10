class AddPlayersToMatches < ActiveRecord::Migration
  def up
    4.times do |n|
      add_column    :matches, "player_#{n+1}_id", :integer
      remove_column :matches, "player_#{n+1}"
    end
  end

  def down
    4.times do |n|
      remove_column :matches, "player_#{n+1}_id"
      add_column    :matches, "player_#{n+1}", :string
    end
  end
end