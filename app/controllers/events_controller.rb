class EventsController < ApplicationController
  
  before_action :require_signin, except: [:index,:show]
  before_action :require_admin, except: [:index,:show]
  before_action :set_event, only: [:show, :exit, :update, :destroy]

    def index
      case params[:filter]

      when "free"
        @events = Event.free
      when "recent"
        @events = Event.recent
      else
        @events = Event.upcoming
      end
    end
  
    def show
      @likers = @event.likers
      @categories = @event.categories
      if current_user
        @like = current_user.likes.find_by(event_id: @event.id)
      end
    end
  
    def edit
    end
  
    def update
      if @event.update(event_params)
        redirect_to @event, notice: "Event successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def new
      @event = Event.new
    end
  
    def create
      @event = Event.new(event_params)
      if @event.save
        redirect_to @event, notice: "Event successfully created!"
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def destroy
      @event.destroy
      redirect_to events_url, status: :see_other
    end
  
  private
  
   def set_event
    @event = Event.find_by!(slug: params[:id])
   end
    def event_params
      params.require(:event).
        permit(:name, :description, :location, :price, :starts_at,
               :capacity, :image_file_name, category_ids: [])
    end
  end
  