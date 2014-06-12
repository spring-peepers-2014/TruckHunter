class CreateTrucks < ActiveRecord::Migration
  def change
    create_table :trucks do |t|
		t.string :name, :null => false
		t.string :twitter_handle, :null => false
		t.boolean :active, :default => true
		t.string :profile_img_url
		t.boolean :approved, :default => false

     	t.timestamps
    end
  end
end
