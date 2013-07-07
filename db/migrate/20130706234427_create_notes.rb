class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :class
      t.string :topic
      t.references :user, index: true

      t.timestamps
    end
  end
end
