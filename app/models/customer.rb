class Customer < ApplicationRecord
  has_many :orders

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
