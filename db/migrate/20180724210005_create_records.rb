class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.string :url, default: ""
      t.boolean :crawled, default: false

      t.timestamps
    end
  end
end
