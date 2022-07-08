class CreateSubs < ActiveRecord::Migration[7.0]
  def change
    create_table :subs do |t|
			t.string :name, null: false 
			t.text :description
			t.integer :moderator_id, null: false 
      t.timestamps
    end
		add_index :subs, :moderator_id
		add_index :subs, :name, unique: true 
  end
end
