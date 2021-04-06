module Api
  module V1
    class BoxesController < Api::V1::BaseController
      before_action :set_box, only: [:show, :update, :destroy]

      def index
        if params[:hormone_id]
          @boxes = Box.where(hormone_id: params[:hormone_id])
          render json: @boxes
        else
          render json: { errors: "Erro ao carregar as caixas!" }, status: :bad_request
        end
      end
      
      # GET /api/v1/boxes/1
      def show
        render json: @box
      end
  
      def create
        @box = Box.new(box_params)

        if @box.save
          render json: @box, status: :created
        else
          render json: @box.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/boxes/1
      def update
        if @box.update(box_params)
          render json: @box
        else
          render json: @box.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/boxes/1
      def destroy
        @box.destroy
      end
      
      private
      
        def set_box
          @box = Box.find(params[:id])
        end
    
        def box_params
          params.require(:box).permit(:hormone_id, :amount, :remaining_amount, :date_start, :expiration_date)
        end
    end
  end
end