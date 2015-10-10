# encoding: utf-8
class Admin::MoneyController < Admin::BaseController
  load_and_authorize_resource

  def index
    @listing = Listing.find(params[:listing_id])
    @money = Money.where(:listing_id => @listing.id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listing }
    end
  end

  def show
    @money = Money.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @money }
    end
  end

  def new
    @money = Money.new(:listing_id => params[:listing_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @money }
    end
  end

  def edit
    @money = Money.find(params[:id])
  end

  def create
    @money = Money.new(params[:money])

    respond_to do |format|
      if @money.save
        format.html { redirect_to admin_listing_money_index_path(:listing_id => params[:listing_id]), notice: 'Se añadió satisfactoriamente inversión en espacio público.' }
        format.json { render json: @money, status: :created, location: @money }
      else
        format.html { render action: "new" }
        format.json { render json: @money.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @money = Money.find(params[:id])

    respond_to do |format|
      if @money.update_attributes(params[:event])
        listing = Listing.find(params[:listing_id])
        format.html { redirect_to admin_listing_money_path(listing), notice: 'Cantidad editada satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @money.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @money = Money.find(params[:id])
    @money.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end