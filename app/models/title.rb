class Title < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :fact
  has_many :year, through: :fact
end
