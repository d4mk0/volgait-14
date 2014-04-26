class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter, :vkontakte]
  simple_roles
  
  has_many :questions
  has_many :answers
  
  def admin?
    has_role?(Role.find_by(name: :admin))
  end
  
  def editor?
    has_role?(Role.find_by(name: :editor))
  end
end
