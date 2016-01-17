class Title < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :fact
end
