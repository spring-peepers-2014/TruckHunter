class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
    	t.belongs_to :truck
    	t.text :issue_body, :null => false

      	t.timestamps
    end
  end
end
