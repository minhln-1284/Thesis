class Message < ApplicationRecord
  belongs_to :user

  validates :message, presence: true,
            length: {maximum: Settings.message.message_max}
end
