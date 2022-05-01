class ExternalDocumentsController < ApplicationController
  expose :external_document, build_params: -> { external_document_params },
    decorate: ->(external_document) { authorize external_document }

  def new
    @external_document = external_document
  end

  def create
    external_document.save!
    redirect_to external_document.incident
  end

  def edit
    @external_document = external_document
  end

  def update
    external_document.update! external_document_params
    redirect_to external_document.incident
  end

  def destroy
    external_document.destroy!
    redirect_to external_document.incident
  end

  private

  def external_document_params
    params
      .require(:external_document)
      .permit(:incident_id, :name, :description, :url)
  end
end
