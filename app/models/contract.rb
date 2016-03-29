class Contract < ActiveRecord::Base
  self.table_name =  "contract"
  self.primary_key = "id"

   has_many :inet_services, class_name: 'InetService', foreign_key: 'contractId'
   has_many :contract_parameter_type1, class_name: 'ContractParameterType1', foreign_key: 'cid'
   has_many :contract_parameter_type2, class_name: 'ContractParameterType2', foreign_key: 'cid'
   has_many :contract_parameter_type3, class_name: 'ContractParameterType3', foreign_key: 'cid'
   has_many :contract_parameter_type6, class_name: 'ContractParameterType6', foreign_key: 'cid'
   has_many :phones, class_name: "Phone", foreign_key: "cid"
   has_many :flags, class_name: "Flag", foreign_key: "cid"
end
