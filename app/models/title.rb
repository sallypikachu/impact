class Title < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :facts
  has_many :years, through: :facts
  has_many :locations, through: :facts
end
