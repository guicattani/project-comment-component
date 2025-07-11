class Activity < ApplicationRecord
  include SoftDeletable
  belongs_to :activitable, polymorphic: true
  belongs_to :user

  validates_presence_of :content
  validates_length_of :content, minimum: 1

  def delete
    super
    update_column :content, "Deleted"
  end

  def serialize
    raise "ERROR: STI Class #{self.class.name} should implement this method and it doesn't"
  end
end
