class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :username # Sweet, so username can be NULL.  Makes sense!  No, actually it doesn't.  Who reviewed this commit?  This shoudl have been caught because you use constraints effectively in your other migrations.  Isabel, you do constraints in the other migrations, you need to help your team along.
    	t.string :password_digest

    	t.timestamps
    end
  end
end
