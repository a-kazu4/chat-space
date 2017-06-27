class Group < ApplicationRecord
  has_many :users, through: :members
  has_many :members
  has_many :messages

  accepts_nested_attributes_for :members

  validates :name, presence: true
  scope :order_by_updated_at, -> { includes(:messages).order('updated_at DESC') }

end
