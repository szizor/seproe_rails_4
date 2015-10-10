# encoding: utf-8
class Admin::DocumentsController < Admin::BaseController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    @documents = Document.all
  end

  def show
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to [:admin, @document], :notice => "Documento Creado con Exito."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @document.update(document_params)
      redirect_to [:admin, @document], :notice  => "Documento Editado con Exito."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document.destroy
    redirect_to admin_documents_url, :notice => "Documento Eliminado con Exito."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :file)
    end
end
