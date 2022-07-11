class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  validates :email, presence: true, 
                    uniqueness: true, 
                    format: {
                      with: /\A[\w.+-]+@[\w-]+\.\w+\z/,
                      message: "Email not valid."
                    }
                    
  validates :password, presence: true

  has_many :restaurants        
end
