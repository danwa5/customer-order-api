class Customer < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
