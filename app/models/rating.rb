class Rating < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :star, presence: true,
                   length: {maximum: Settings.review.rating_max,
                            minimum: Settings.review.rating_min}

  validates :comment, presence: true,
            length: {maximum: Settings.message.message_max}

  scope :newest, ->{order created_at: :desc}

  RATING_PARAMS = %i(comment star user_id product_id).freeze
end
