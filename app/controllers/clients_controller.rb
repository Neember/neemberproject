class ClientsController < ApplicationController

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_param)

    if @client.save
      redirect_to clients_path, notice: 'New client added successfully'
    else
      flash[:alert] = 'Failed to create client'
      render :new
    end
  end

  protected
  def client_param
    params.require(:client).permit(:title, :first_name, :last_name, :email, :phone, :address, :company_name, :designation)
  end
end
