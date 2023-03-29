# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  module AccessLevel
    READ_ONLY = 0
    FULL = 99
  end

  validates :access_level, inclusion: { in: AccessLevel.constants.map { |level| AccessLevel.const_get(level) } }

  def full_access?
    access_level == AccessLevel::FULL
  end
end
