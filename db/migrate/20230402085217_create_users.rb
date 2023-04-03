class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :password_digest
      t.string  :token
      t.boolean :admin, default: false
      t.boolean :email_confirmed, default: false
      t.timestamps
    end
  end
end
