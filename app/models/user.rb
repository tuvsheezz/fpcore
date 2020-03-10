class User < ApplicationRecord
  belongs_to :role
  has_many :debts
  has_many :products
  has_many :ratedollars
  has_many :rateyuans
  has_one_attached :image
  validates :name, presence: {message: 'хоосон байж болохгүй' }
  validates :email, presence: {message: 'хоосон байж болохгүй' }
  validates :password, presence: {message: 'хоосон байж болохгүй' }
  validates :phone, presence: {message: 'хоосон байж болохгүй' }, numericality: {message: 'зөвхөн тоогоор оруулна уу.' }
  validates :phone2, presence: {message: 'хоосон байж болохгүй' }, numericality: {message: 'зөвхөн тоогоор оруулна уу.' }
  validates :address, presence: {message: 'хоосон байж болохгүй' }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

end
