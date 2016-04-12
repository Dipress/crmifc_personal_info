class PersonalsController < ApplicationController
  require "net/ssh"
  before_filter :find_contract, only: [:new, :create, :edit, :update]

  PERMITTED_PARAMS = [:contract_id, :contract_title, :contract_comment, :fio, :address_post,
                      :address_connection, :telephone, :birthday, :passport, :passport_date, :passport_authority]

  def index
    @personals = Personal.all
  end

  def new
    @personal = Personal.new
  end

  def create
    @personal = Personal.new(create_params)
    if @personal.save
      Net::SSH.start('hostname', "admin", password: "password") do |ssh|
        ssh.exec!("/ip firewall address-list remove [find where comment=#{@r}]")
      end
      @contract.flags.where(pid: 72).update_all(val: 0)
      redirect_to @personal
    else
      render :new
    end
  end

  def show
    @personal = Personal.find(params[:id])
  end

  def edit
    @personal = Personal.find(params[:id])
  end

  def update
    @personal = Personal.find(update_params)
    if @personal.update(params[:personal])
      redirect_to @personal
    else
      render :edit
    end
  end

  def delete
    @personal = Personal.find(params[:id])
  end

  def destroy
    @personal = Personal.find(params[:id])
    @personal.destroy
    redirect_to @personal
  end

  def create_params
    params.require(:personal).permit(PERMITTED_PARAMS)
  end

  def update_params; create_params end

  def find_contract
    #@r = request.remote_ip
    #@url = request.url
    @r = "10.10.230.170"
    ip = @r.split('.').collect(&:to_i).pack('C*')
    inet = InetService.find_by(addressFrom: ip)
    @contract = Contract.find(inet.contractId)
  end

end
