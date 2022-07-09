class CreateUserVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_votes do |t|
			t.integer :value, null: false 
			t.integer :user_id, null: false 
			t.string :votable_type, null: false 
			t.integer :votable_id, null: false
      t.timestamps
    end
		add_index :user_votes, :user_id 
		add_index :user_votes, %i(votable_type votable_id)
		add_index :user_votes, %i(user_id votable_type votable_id), unique: true
  end
end
