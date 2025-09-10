class Invoice < ApplicationRecord
  acts_as_paranoid

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  accepts_nested_attributes_for :invoice_items, allow_destroy: true

  before_save :calculate_total

  validates :customer_name, presence: true

  private

  def calculate_total
    self.total_price = invoice_items.sum { |line| line.price.to_f * line.quantity.to_i }
  end
end
