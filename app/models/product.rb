class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_many :ratings, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  has_many :product_images, dependent: :destroy, inverse_of: :product

  accepts_nested_attributes_for :product_images, allow_destroy: true

  delegate :name, to: :category, prefix: true

  validates :price, :quantity_in_stock, presence: true

  scope :by_name, (lambda do |name|
                     where("name LIKE (?)", "%#{name}%") if name.present?
                   end)
  scope :order_by_price, ->(criteria){order(price: criteria)}
  scope :find_category_id, ->(param){where category_id: param}
  scope :order_by_created_at, ->(param){order(created_at: param)}
  scope :newest, ->{order created_at: :desc}
  scope :by_ids, ->(ids){where id: ids}
  scope :uncategorized, ->{where category_id: nil}
end
