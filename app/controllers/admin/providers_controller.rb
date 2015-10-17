# encoding: utf-8
class Admin::ProvidersController < Admin::BaseController
  def index
    @providers = Provider.all
  end

  def show
    @provider = Provider.find(params[:id])
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(params[:provider])
    if @provider.save
      redirect_to admin_providers_url, :notice => "Provedor creado con exito."
    else
      render :action => 'new'
    end
  end

  def edit
    @provider = Provider.find(params[:id])
  end

  def update
    @provider = Provider.find(params[:id])
    if @provider.update_attributes(params[:provider])
      redirect_to admin_providers_url, :notice  => "Provedor editado con exito."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy
    redirect_to admin_providers_url, :notice => "Provedor eliminado con exito."
  end
end
