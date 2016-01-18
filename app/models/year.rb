class Year < ActiveRecord::Base
  validates :year, presence: true, uniqueness: true

  has_many :fact
  has_many :title, through: :fact
end
