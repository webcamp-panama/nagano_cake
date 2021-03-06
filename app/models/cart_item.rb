class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

 validates :quantity, numericality: {greater_than: 0}


  def subtotal
    item.with_tax_price * quantity
  end

   def sum_of_price
    item.taxin_price * quantity
   end
end
