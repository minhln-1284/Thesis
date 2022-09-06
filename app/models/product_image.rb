class ProductImage < ApplicationRecord
  belongs_to :product

  has_one_attached :image

  def thumbnail _input
    image.variant(resize: "300x300").processed
  end
end
