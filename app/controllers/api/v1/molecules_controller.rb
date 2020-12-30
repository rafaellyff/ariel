module Api
  module V1
    class MoleculesController < Api::V1::BaseController
      before_action :set_molecule, only: [:show, :update, :destroy]

      def index
        @molecules = Molecule.all
        render json: @molecules
      end
      
      # GET /api/v1/molecules/1
      def show
        render json: @molecule
      end
  
      def create
        @molecule = Molecule.new(molecule_params)#.merge(user: current_user))

        if @molecule.save
          render json: @molecule, status: :created
        else
          render json: @molecule.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/molecules/1
      def update
        if @molecule.update(molecule_params)
          render json: @molecule
        else
          render json: @molecule.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/molecules/1
      def destroy
        @molecule.destroy
      end
      
      private
      
        def set_molecule
          @molecule = molecule.find(params[:id])
        end
    
        def molecule_params
          params.require(:molecule).permit(:name)
        end
    end
  end
end