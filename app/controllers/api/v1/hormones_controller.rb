module Api
  module V1
    class HormonesController < Api::V1::BaseController
      before_action :set_hormone, only: [:show, :update, :destroy]

      def index
        @hormones = Hormone.where(user_id:  params[:user_id])
        render json: @hormones.to_json(methods: [:boxes_count], :include => {:molecule => {:only => :name}}) 
      end
      
      # GET /api/v1/hormones/1
      def show
        render json: @hormone , :include => {:molecule => {:only => :name}}
      end
  
      def create
        @hormone = Hormone.new(hormone_params)

        if @hormone.save
          render json: @hormone.to_json(methods: [:boxes_count], :include => {:molecule => {:only => :name}}) , status: :created
        else
          render json: @hormone.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/hormones/1
      def update
        if @hormone.update(hormone_params)
          render json: @hormone
        else
          render json: @hormone.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/hormones/1
      def destroy
        @hormone.destroy
      end
      
      private
      
        def set_hormone
          @hormone = Hormone.find(params[:id])
        end
    
        def hormone_params
          params.require(:hormone).permit(:molecule_id, :name, :periodicity, :unit, :unit_per_dose, :user_id)
        end
    end
  end
end