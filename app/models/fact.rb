class Fact < ActiveRecord::Base
  validates :title_id, presence: true
  validates :year_id, presence: true
  validates :data, presence: true
  validates :location, presence: true

  belongs_to :title
  belongs_to :year
end
