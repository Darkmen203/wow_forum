class User < ApplicationRecord
  validates :id, :provider, :login, :token, presence: true
  validates :id, uniqueness: { scope: :provider }
  has_many :questions
  has_many :answers


end
