class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_waiting: 0, payment_confirm: 1, making: 2, prepare_shipping: 3, shipping_out: 4 }

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :cart_items

  validates :address, presence: true
  validates :name, presence: true
  validates :postcode, presence: true


  def add_tax_on_price
    (self.price * 1.10).round
  end

  #def subtotal
    #item.add_tax_on_price*order.quantity
  #end

end
