class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_lines

  validates :customer_id, presence: true
  # validates :order_date, presence: true

  before_validation :set_order_date

  private

  def set_order_date
    # self.order_date = DateTime.now if order_date.nil?
  end
end
