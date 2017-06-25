class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  scope :updated_at, -> { order('updated_at DESC') }
  mount_uploader :image, MessageUploader
  validates :body_or_image, presence: true

  private
  def body_or_image
    body.presence or image.presence
  end
end
