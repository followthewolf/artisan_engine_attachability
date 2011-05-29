class CreatePotatoHeads < ActiveRecord::Migration
  def self.up
    create_table :potato_heads do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :potato_heads
  end
end
