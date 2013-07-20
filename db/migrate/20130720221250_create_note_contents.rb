class CreateNoteContents < ActiveRecord::Migration
  def change
    create_table :note_contents do |t|
      t.references :note, index: true

      t.timestamps
    end
  end
end
