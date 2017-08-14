module CommonModule
  extend ActiveSupport::Concern
  included do
    scope :newest, -> { includes(:messages).order('updated_at DESC') }
  end
end
