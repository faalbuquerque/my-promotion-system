class CreateCategoryPromotions < ActiveRecord::Migration[6.1]
  def change
    create_table :category_promotions do |t|
      t.integer :promotion_id
      t.integer :category_id
      t.timestamps
    end
  end
end
