class Personal
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Slug

  field :contract_id, type: Integer
  field :contract_title, type: String
  field :contract_comment, type: String
  field :fio, type: String
  field :address_post, type: String
  field :address_connection, type: String
  field :telephone, type: Integer
  field :birthday, type: String
  field :passport, type: String
  field :passport_date, type: String
  field :passport_authority, type: String

  slug :contract_id

  VALID_DATE_REGEX = /\A(\d{1,2}).(\d{1,2}).(\d{4})\z/
  VALID_PHONE_REGEX = /\A79\d{9}\z/

  validates :contract_id, :contract_title, :contract_comment, :fio, :address_post, :address_connection, :passport, :passport_authority, presence: true

  validates :birthday, :passport_date,  presence: true, format: { with: VALID_DATE_REGEX }
  validates :telephone, presence: true, format: { with: VALID_PHONE_REGEX }
end
