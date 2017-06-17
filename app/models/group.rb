class Group < ApplicationRecord
  has_many :users, through: :members
  has_many :members
  accepts_nested_attributes_for :members
  validate :add_error_name
  def add_error_name
    if name.blank?
      errors[:base] << "グループ名を入力して下さい"
    end
  end
end
