class User < ApplicationRecord
  validates :provider, :login, :token, presence: true
  has_many :questions
  has_many :answers


end
