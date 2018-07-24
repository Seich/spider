class CreateHeaders < ActiveRecord::Migration[5.2]
  def change
    create_table :headers do |t|
      t.string :level
      t.string :content
      t.references :record

      t.timestamps
    end
  end
end
