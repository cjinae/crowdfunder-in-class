class Project < ActiveRecord::Base
  belongs_to :user
  has_many :pledges

  validates :title, presence: true, length: {maximum: 100}
  validates :teaser, presence: true, length: {maximum: 255}
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greather_than: 0, allow_blank: true}


  attr_accessible :description, :goal, :teaser, :title
end
