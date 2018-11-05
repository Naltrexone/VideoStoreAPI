class Customer < ApplicationRecord
  validate :name, presence: true
  validate :registered_at, presence: true
  validate :address, presence: true
  validate :city, presence: true
  validate :state, presence: true
  validate :postal_code, presence: true
  validate :phone, presence: true
end
