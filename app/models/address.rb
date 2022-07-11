class Address < ApplicationRecord

  validates :street, 
    presence: true, 
    format: { with: /\A[a-zA-Z0-9 \'.-]+\z/ },
    length: { minimum: 5 }

  validates :zipcode, 
    presence: true,  
    format: { with: /\A[0-9]+\z/ },
    numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    length: { minimum: 1, maximum: 10 }

  validates :town, 
    presence: true, 
    format: { with: /\A[a-zA-Z \'.-]+\z/ },
    length: { minimum: 3 }

  validates :country, 
    presence: true, 
    format: { with: /\A[a-zA-Z \-'.,\(&\)!]+\z/ },
    length: { minimum: 3 }

  belongs_to :restaurant

  scope :filter_by_country, ->(country) { where(restaurant: Address.where(country: country)) }
  scope :filter_by_town, ->(town) { where(restaurant: Address.where(town: town)) }
  scope :filter_by_zipcode, ->(zipcode) { where(restaurant: Address.where(zipcode: zipcode)) }

end