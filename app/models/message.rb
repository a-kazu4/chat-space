class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  mount_uploader :image, MessageUploader

  validates :body_or_image, presence: true

  include ScopeNewest

  private

  def body_or_image
    body.presence or image.presence
  end
end
