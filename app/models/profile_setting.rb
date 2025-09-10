class ProfileSetting < ApplicationRecord
  validates :company_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phone, length: { maximum: 15 }, allow_blank: true
end
