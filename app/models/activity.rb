class Activity < ApplicationRecord
  include SoftDeletable
  belongs_to :activitable, polymorphic: true
  belongs_to :user

  validates_presence_of :content, :activitable_type, :activitable_id, :user_id

  def serialize
    raise "ERROR: STI Class #{self.class.name} should implement serialize and it doesn't"
  end

  def action
    raise "ERROR: STI Class #{self.class.name} should implement action and it doesn't"
  end
end
