class CategoryPromotion < ApplicationRecord
  belongs_to :promotion
  belongs_to :category
end
