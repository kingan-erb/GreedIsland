class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true
  has_many :cart_items
  has_many :orders
  belongs_to :greed

  validates :email, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :phone_number, presence: true
  validates :last_name_kana, presence: true
  validates :greed_id, presence: true
  validates :customer_status, presence: true
  validates :payment_method, presence: true
  validates :default_address, presence: true


  def self.search(search)
    if search
      User.where(['(last_name LIKE ?) OR (first_name LIKE ?)', "%#{search}%","%#{search}%"])
    else
      User.all
    end
  end

  def soft_delete
    update(deleted_at: Time.now)
  end

  def active_for_authentication?
    !deleted_at
  end

  def inactive_message
    !deleted_at ? super : :deleted_account
  end
end
