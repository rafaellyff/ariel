module Api
  module V1
    class CalendarController < Api::V1::BaseController
      
      def next_events
        @events = Event.where("scheduled_date >= ? AND user_id =? ", Date.current, params[:user_id]) + Dose.where("scheduled_date >= ? AND user_id =? ", Date.current, params[:user_id])
        @events =  @events.sort_by(&:scheduled_date)
        
        render json: @events
      end

      def filter_events
        @star_date = Date.new(params[:year].to_i,params[:month].to_i,1)
        @end_date = @star_date.end_of_month

        @events = Event.where(scheduled_date: @star_date..@end_date, user_id:  params[:user_id]) + Dose.where(scheduled_date: @star_date..@end_date,  user_id:  params[:user_id])
        @events =  @events.sort_by(&:scheduled_date)
    
        render json: @events
      end

    end
  end
end


