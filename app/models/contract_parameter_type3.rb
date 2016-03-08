class ContractParameterType3 < ActiveRecord::Base
  self.table_name = "contract_parameter_type_3"
  self.primary_key = "pid"

  belongs_to :contract, class_name: 'Contract', foreign_key: 'cid'
end
