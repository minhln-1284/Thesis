class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable, :recoverable

  enum role: {Admin: 0, User: 1}
  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :messages, dependent: :destroy

  USER_ATTRIBUTES = %i(name email phone address password
                       password_confirmation).freeze
  USER_UPDATE = %i(name phone address password
                  password_confirmation).freeze

  scope :newest, ->{order created_at: :desc}

  scope :best_user, ->(best){where id: best}

  scope :this_month, (lambda do
    where(created_at:
      DateTime.now.beginning_of_month..DateTime.now.end_of_month)
  end)

  before_save :downcase_email
  before_create :create_activation_digest

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def ordered? product_id
    order_ids = User.find_by(id: id).orders.Delivered.ids
    OrderDetail.order_by_ids(order_ids)
               .pluck(:product_id).include?(product_id)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.blank?

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_mail_activate
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token),
                   reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.password_reset.expired.hours.ago
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
