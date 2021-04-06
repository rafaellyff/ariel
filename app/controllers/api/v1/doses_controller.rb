module Api
  module V1
    class DosesController < Api::V1::BaseController
      before_action :set_dose, only: [:show, :update, :destroy]

      def index
        @doses = Dose.where("scheduled_date >= ?", Date.current);
        render json: @doses
      end
      
      # GET /api/v1/doses/1
      def show
        render json: @dose
      end
  
      def create
        @dose = Dose.new(dose_params)#.merge(user: current_user))

        if @dose.save
          render json: @dose, status: :created
        else
          render json: @dose.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/doses/1
      def update
        if @dose.update(dose_params)
          render json: @dose
        else
          render json: @dose.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/doses/1
      def destroy
        @dose.destroy
      end

      def next_dose
        dose = Dose.select(:scheduled_date).where("user_id = ? AND scheduled_date >= ?", params[:user_id], Date.current).order(:scheduled_date).limit(1)
        if dose.blank?
          render json: { exists: false , days: 0 }
        else
          date = dose.first.scheduled_date
          days = (date - Date.today).to_i
        end

        render json: { exists: true , days: days}
      end

      def confirm_dose
        dose = Dose.find(params[:dose_id])
        dose.update(status: 'done')

        periodicity = dose.hormone.periodicity
        new_date = dose.scheduled_date + periodicity.days
        
        if dose.apply_on == 'left' 
          apply_on = 'right'  
        elsif dose.apply_on == 'right' 
          apply_on = 'left'
        else
          apply_on = 'indifferent'
        end

        Dose.create(hormone_id: dose.hormone_id, scheduled_date: new_date, apply_on: apply_on)

        search_boxes = Box.where("hormone_id  =? AND remaining_amount > ?", params[:hormone_id], 0).order(remaining_amount: :asc)
        if search_boxes.blank?
          render json: { errors: "Você não possui caixas cadastradas desse hormônio!" }, status: 200
        else 
          box = search_boxes.first
          new_amount = box.remaining_amount - dose.amount

          if new_amount >= 0 
            box.update(remaining_amount: new_amount)
            render json: { errors: "" }, status: 200
          else 
            box.update(remaining_amount: 0)
            box_two = Box.where("hormone_id  =? AND remaining_amount > ?", params[:hormone_id], 0).order(remaining_amount: :desc).first
            if box_two.blank?
              render json: { errors: "Suas caixas de hormônio acabaram" }, status: 200
            else
              new_amount_two = box_two.remaining_amount - new_amount
              box.update(remaining_amount: new_amount_two)
              render json: { errors: "" }, status: 200
            end
          end
        end
      end
      
      private
      
        def set_dose
          @dose = Dose.find(params[:id])
        end
    
        def dose_params
          params.require(:dose).permit(:hormone_id, :amount, :realized_date, :realized_amount, :annotation, :status, :new_date, :apply_on,:scheduled_date, :user_id)
        end
    end
  end
end


