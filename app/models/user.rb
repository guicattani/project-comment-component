class User < ApplicationRecord
  validates :name, uniqueness: true

  has_many :activities, dependent: :delete_all

  validates_presence_of :name
  validates_length_of :name, minimum: 1
end
