class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :topic
      t.references :note, index: true

      t.timestamps
    end
  end
end
