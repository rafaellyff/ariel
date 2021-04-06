module Api
  module V1
    class EventsController < Api::V1::BaseController
      before_action :set_event, only: [:show, :update, :destroy]

      def index
        @events = Event.where("scheduled_date >= ?", Date.current);
        render json: @events
      end
      
      # GET /api/v1/events/1
      def show
        render json: @event
      end
  
      def create
        @event = Event.new(event_params)#.merge(user: current_user))

        if @event.save
          render json: @event, status: :created
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/events/1
      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/events/1
      def destroy
        @event.destroy
      end
      
      private
      
        def set_event
          @event = Event.find(params[:id])
        end
    
        def event_params
          params.require(:event).permit(:name, :scheduled_date, :description, :user_id)
        end
    end
  end
end