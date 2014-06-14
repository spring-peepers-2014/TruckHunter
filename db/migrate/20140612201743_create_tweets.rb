class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
    	t.belongs_to :truck
    	t.text :body, :null => false
    	t.datetime :tweet_time, :null => false

    	t.timestamps
    end
  end
end
