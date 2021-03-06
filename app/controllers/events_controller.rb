# coding: utf-8
class EventsController < ApplicationController

  include EventsHelper

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :event_owner!, only: [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.order(:start_at)
    p "**** request.session_options[:id] = #{request.session_options[:id]}"
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @events = Event.all.order(:start_at)
    @new_event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @events = Event.all
    @new_event = Event.new(event_params)
    @new_event.session_id = request.session_options[:id]

    respond_to do |format|
      if @new_event.save
        format.html { redirect_to root_path(eid: @new_event.id), notice: 'イベントを作成しました' }
      else
        format.html { 
          flash.now[:alert] = "イベントの作成に失敗しました"
          render action: 'new' 
        }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to root_path(eid: @event.id), notice: 'イベントを更新しました' }
      else
        format.html { 
          flash.now[:alert] = "イベントの編集に失敗しました"
          render action: 'edit' 
        }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'イベントを削除しました'  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def event_owner!
      redirect_to root_path, :alert => '作成者のみ編集可能です' unless my_event?(@event)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:url, :event_date, :title, :place, :address, :price, :capacity, :start_at, :end_at, :prefecture_id, :cat_beginner_flg, :cat_pro_flg)
    end
end
