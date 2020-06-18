class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, length: { maximum: 50 }
  validates :self_introduction, length: { maximum: 300 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :musicposts, dependent: :destroy
end
