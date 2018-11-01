class AddLikeToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :like, :integer
  end
end
