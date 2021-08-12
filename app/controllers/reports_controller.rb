class ReportsController < ApplicationController
  before_action :find_team, only: [:index, :show, :update]
  # layout :application

  # GET /reports
  # GET /reports.json
  def index
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @date = params[:date].try(:to_date) || Date.today
    @reports = Report.all
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    raise true.inspect
    respond_to do |format|
      if @report.save
        format.html { redirect_to [@team, :report, { date: params[:date], token: params[:token]}], notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if FirestoreService.new(date: Date.today, team: @team).sync_progress_for_week
        format.html { redirect_to [@team, :report, { date: params[:date], token: params[:token]}], notice: 'Report was updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def find_team
      @team = Team.find_by(team_id: params[:team_id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.fetch(:report, {})
    end
end
