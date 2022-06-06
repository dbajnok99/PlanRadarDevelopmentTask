class User < ApplicationRecord
  has_many :tickets, inverse_of: :user, dependent: :destroy
end
