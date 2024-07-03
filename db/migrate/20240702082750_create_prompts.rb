class CreatePrompts < ActiveRecord::Migration[7.1]
  def change
    create_table :prompts do |t|
      t.text :value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
