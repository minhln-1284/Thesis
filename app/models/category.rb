class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  has_many :categories, dependent: :nullify

  belongs_to :category, optional: true

  validates :name, presence: true

  before_save :create_path

  scope :newest, ->{order created_at: :desc}

  scope :mens, ->{where category_id: 1}

  scope :womans, ->{where category_id: 2}

  ransacker :category_id, type: :BIGINT do
    Arel.sql("BIGINT(category_id)")
  end

  def create_path
    return if category_id.blank?

    next_category = Category.find_by id: category_id
    self.parent_path = [next_category.parent_path, category_id].join("/")
  end
end
