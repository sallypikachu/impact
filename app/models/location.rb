class Location < ActiveRecord::Base
  validates :country, presence: true, uniqueness: true

  has_many :facts
  has_many :years, through: :facts
  has_many :titles, through: :facts
end
