class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_many :ratings, dependent: :destroy
  has_many :order_details
  has_many :orders, through: :order_details
  has_many :product_images, dependent: :destroy, inverse_of: :product
  acts_as_paranoid without_default_scope: true

  accepts_nested_attributes_for :product_images, allow_destroy: true

  delegate :name, to: :category, prefix: true

  validates :price, :quantity_in_stock, presence: true

  scope :mens, ->{where("products.category_id IN (?)", [3,5,7,9])}

  scope :womans, ->{where("products.category_id IN (?)", [4,6,8,10,11])}

  scope :by_name, (lambda do |name|
                     where("name LIKE (?)", "%#{name}%") if name.present?
                   end)
  scope :order_by_price, ->(criteria){order(price: criteria)}
  scope :find_category_id, ->(param){where category_id: param}
  scope :order_by_created_at, ->(param){order(created_at: param)}
  scope :newest, ->{order created_at: :desc}
  scope :oldest, ->{order created_at: :asc}
  scope :by_ids, ->(ids){where id: ids}
  scope :uncategorized, ->{where category_id: nil}
  scope :by_category, ->(category_id){where category_id: category_id}
  scope :cheapest, ->{order price: :asc}
  scope :most_expensive, ->{order price: :desc}
  scope :categorized, ->{where.not(category_id: nil)}

  def find_root_category parent_path
    arr = parent_path.split("/")
    return arr.second
  end
end
