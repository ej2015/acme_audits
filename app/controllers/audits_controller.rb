class AuditsController < ApplicationController
  before_action :set_audit, only: [:show, :edit, :destroy]

  # GET /audits
  # GET /audits.json
  def index
    @filterrific = initialize_filterrific(
      Audit,
      params[:filterrific],
      select_options: {
        auditable_type: Audit.options_for_auditable_type
      },
      available_filters: [:with_auditable_id, :with_auditable_type, :with_timestamp]
    ) or return
    @audits = @filterrific.find.page params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /audits/1
  # GET /audits/1.json
  def show
  end

  # GET /audits/new
  def new
    @audit = Audit.new
  end

  # GET /audits/1/edit
  def edit
  end

  # POST /audits
  # POST /audits.json
  def create
    respond_to do |format|
      if AuditCreationService.new(audit_params[:file].path).call
        format.html { redirect_to audits_path, notice: 'Audit was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /audits/1
  # DELETE /audits/1.json
  def destroy
    @audit.destroy
    respond_to do |format|
      format.html { redirect_to audits_url, notice: 'Audit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audit
      @audit = Audit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audit_params
      params.require(:audit).permit(:file)
    end
end
