class InetService < ActiveRecord::Base
  self.table_name = "inet_serv_14"
  belongs_to :contract, class_name: 'Contract', foreign_key: 'contractId'
end
