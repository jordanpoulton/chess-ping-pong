class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :player_id
      t.integer :opponent_id
      t.boolean :victory

      t.timestamps
    end
  end
end
