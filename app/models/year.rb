class Year < ActiveRecord::Base
  validates :year, presence: true, uniqueness: true

  has_many :facts
  has_many :titles, through: :facts
  has_many :locations, through: :facts
end
