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
    @audits = @filterrific.find.order(:timestamp).page params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @audit = Audit.new
  end

  def create
    file = audit_params[:file]
    respond_to do |format|
      if AuditCreationService.new(file).call
        format.html { redirect_to audits_path, notice: 'Audit was successfully created.' }
      else
        format.html { render :new }
      end
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
