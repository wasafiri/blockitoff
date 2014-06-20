class AddAuthenticationTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :text
    add_index  :users, :authentication_token, :unique => true
  end
end
