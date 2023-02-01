class ChangePostsCounterToNewFromUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.change :posts_counter, :bigint, :default => 0
    end
  end
end
