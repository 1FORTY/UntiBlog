class CreatePost < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :post_messsage

      t.timestamps
    end
  end
end
