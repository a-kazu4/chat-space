module CommonModule
  extend ActiveSupport::Concern
  included do
    scope :newest_order_by_messages_created_at, -> { includes(:messages).order('messages.updated_at DESC') }
  end
end
