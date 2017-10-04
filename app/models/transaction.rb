class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful,     -> { where(result: 'success') }
  scope :not_successful, -> { where(result: 'failed') }

  default_scope { order(:id) }
end
