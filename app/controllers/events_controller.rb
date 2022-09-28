class EventsController < ApplicationController

    def index
        @events = Event.upcoming
    end

    def show
        @event = Event.find(params[:id])
    end

    def edit
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])
        @event.update(event_params)
        redirect_to @event
    end

    def new
        @event= Event.new
    end

    def create
        @event = Event.new(event_params)
        @event.save
        redirect_to @event
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to events_url, status: :see_other
    end
private
    def event_params
        params.require(:event).
            permit(:name, :description, :locations, :price, :starts_at, :capacity, :image_file_name)
    end
end
