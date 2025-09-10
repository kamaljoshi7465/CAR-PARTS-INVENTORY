class InvoiceItem < ApplicationRecord
  acts_as_paranoid

  belongs_to :invoice
  belongs_to :item

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validate :enough_stock?

  def enough_stock?
    if item.present? && quantity.to_i > item.quantity
      errors.add(:base, "Not enough stock for #{item.name}")
    end
  end

  after_create :decrease_item_stock
  after_update :adjust_item_stock
  after_destroy :restore_item_stock

  private

  def enough_stock_available
    if item && quantity.to_i > item.quantity
      errors.add(:quantity, "cannot be greater than available stock (#{item.quantity})")
    end
  end

  def decrease_item_stock
    item.update!(quantity: item.quantity - quantity)
  end

  def adjust_item_stock
    if saved_change_to_quantity?
      diff = quantity - quantity_before_last_save
      item.update!(quantity: item.quantity - diff)
    end
  end

  def restore_item_stock
    item.update!(quantity: item.quantity + quantity)
  end
end
