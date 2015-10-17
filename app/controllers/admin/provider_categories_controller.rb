# encoding: utf-8
class Admin::ProviderCategoriesController < Admin::BaseController
  def index
    @provider_categories = ProviderCategory.all
  end

  def show
    @provider_category = ProviderCategory.find(params[:id])
  end

  def new
    @provider_category = ProviderCategory.new
  end

  def create
    @provider_category = ProviderCategory.new(params[:provider_category])
    if @provider_category.save
      redirect_to admin_provider_categories_url, :notice => "Categoria creada extosamente."
    else
      render :action => 'new'
    end
  end

  def edit
    @provider_category = ProviderCategory.find(params[:id])
  end

  def update
    @provider_category = ProviderCategory.find(params[:id])
    if @provider_category.update_attributes(params[:provider_category])
      redirect_to admin_provider_categories_url, :notice  => "Categoria editada extosamente."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @provider_category = ProviderCategory.find(params[:id])
    if @provider_category.providers.present?
      redirect_to admin_provider_categories_url, :notice  => "No se puede eliminar una categoría que ha vinculado a los proveedores! Elimine los proveedores primero y vuelva a intentarlo más tarde!"
    else
      @provider_category.destroy
      redirect_to admin_provider_categories_url, :notice => "Categoria eliminada extosamente."
    end
  end
end
