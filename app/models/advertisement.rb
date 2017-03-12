class Advertisement < ApplicationRecord
  validates :user_id, presence: true
  belongs_to :user



# Support for calling #default_scope without a block is removed.
# For example instead of `default_scope where(color: 'red')`, please use `default_scope { where(color: 'red') }`

  default_scope { order('advertisements.created_at DESC') } #DESC = descending

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :price, presence: true
  validates :preferred_contact, presence: true
  validates :location, presence: true
end
