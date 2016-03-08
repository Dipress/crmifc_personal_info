class PersonalsController < ApplicationController
  before_filter :find_contract, only: [:show, :edit, :update]
  
  def show
  end

  def edit
    @contract.contract_parameter_type1.build
    @contract.contract_parameter_type2.build
    @contract.contract_parameter_type3.build
    @contract.contract_parameter_type6.build
  end

  def update
    if @contract.update(contract_params)
      redirect_to personal_show_path
    else
      render "edit"
    end
  end

  def find_contract
    #request = request.remote_ip
    request = "10.22.183.151"
    ip = request.split('.').collect(&:to_i).pack('C*')
    @inet = InetService.find_by(addressFrom: ip)
    @contract = Contract.find(@inet.contractId)
  end

  def contract_params
    params.require(:contract).permit(:title, :comment,
                                      contract_parameter_type1_attributes: [:pid, :val],
                                      contract_parameter_type2_attributes: [:pid, :address],
                                      contract_parameter_type3_attributes: [:pid, :email],
                                      contract_parameter_type6_attributes: [:pid, :val],
                                      phones_attributes: [:pid, :value]
                                      )
  end
end
