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

  def edit
    @client = Client.find(client_id)
  end

  def update
    @client = Client.find(client_id)

    if @client.update(client_param)
      redirect_to clients_path, notice: 'Update client successfully'
    else
      flash[:alert] = 'Failed to update client'
      render :edit
    end
  end

  def destroy
    @client = Client.find(client_id)
    if @client.destroy
      redirect_to clients_path, notice: 'Delete client successfully'
    else
      redirect_to clients_path, alert: 'Failed to delete client'
    end
  end


  protected
  def client_id
    params.require(:id)
  end

  def client_param
    params.require(:client).permit(:title, :first_name, :last_name, :email, :phone, :address, :company_name, :designation)
  end
end
