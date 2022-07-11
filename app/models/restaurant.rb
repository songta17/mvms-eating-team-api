class Restaurant < ApplicationRecord

  validates :name, 
    presence: true, 
    uniqueness: true, 
    format: { 
      with: /\A[a-zA-Z0-9 '.&]+\z/,
      message: "only allows letters, numbers, space and apostrophe!" 
    },
    length: { minimum: 3 }

  belongs_to :user
  has_one :address

  scope :authored_by, ->(email) { where(user: User.where(email: email)) }

  # def self.info
  #     { count: self.count }
  # end
end
