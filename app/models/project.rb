class Project < ApplicationRecord
  include SoftDeletable

  enum :status, %i[to_do active done archived]

  has_many :activities, as: :activitable

  validates :name, uniqueness: true
  validates_presence_of :name, :status
  validates_length_of :name, minimum: 1
  validates_length_of :description, minimum: 1
end
