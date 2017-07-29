class UpdocsController < ApplicationController
  def index
      @updocs = Updoc.all
   end
   
   def new
      @updoc = Updoc.new
   end
   
   def create
      @updoc = Updoc.new(updoc_params)
      
      if @updoc.save
         redirect_to updocs_path, notice: "The #{@updoc.name} file has been uploaded."
      else
         render "new"
      end
      
   end
   
   def destroy
      @updoc = Updoc.find(params[:id])
      @updoc.destroy
      redirect_to updocs_path, notice:  "The #{@updoc.name} has been deleted."
   end
   
   private
      def updoc_params
         params.require(:updoc).permit(:name, :attachment)
      end
   
end
