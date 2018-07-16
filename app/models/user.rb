class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :addresses
  accepts_nested_attributes_for :addresses
  # has_many :cart_items
  has_many :orders
  belongs_to :greed

  def self.search(search)
    if search
      User.where(['(last_name LIKE ?) OR (first_name LIKE ?)', "%#{search}%","%#{search}%"])
    else
      User.all
    end
  end
end
