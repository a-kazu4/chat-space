module ScopeNewest
  extend ActiveSupport::Concern
  included do
    scope :newest, -> { order('updated_at DESC') }
  end
end
