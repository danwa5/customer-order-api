class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_lines

  ORDER_STATUSES = ['ready', 'on its way', 'delivered'].freeze

  validates :customer_id, presence: true
  validates :order_date, presence: true
  validates :status, inclusion: { in: ORDER_STATUSES, allow_nil: true }

  before_create :set_status

  private

  def set_status
    self.status = 'ready' if status.nil?
  end
end
