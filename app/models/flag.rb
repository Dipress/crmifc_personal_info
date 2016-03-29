class Flag < ActiveRecord::Base
  self.table_name = "contract_parameter_type_5"
  self.primary_key = "cid"
  belongs_to :contract, class_name: 'Contract', foreign_key: 'cid'
end