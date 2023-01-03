class DocumentsController < ApplicationController
  expose :document, build_params: -> { document_params },
    decorate: ->(document) { authorize document }

  def new
    @document = document
  end

  def edit
    @document = document
  end

  def create
    document.save!
    redirect_to document.incident
  end

  def update
    document.update! document_params
    redirect_to document.incident
  end

  def destroy
    document.destroy!
    redirect_to document.incident
  end

  private

  def document_params
    params
      .require(:document)
      .permit(:incident_id, :name, :description, :url)
  end
end
