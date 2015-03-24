class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user)
      authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
      authorize @wiki
  end

  def new
    @wiki = Wiki.new
      authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
        authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
      if @wiki.update_attributes(wiki_params)
        flash[:notice] = "Wiki was updated." 
        redirect_to @wiki  
      else
        flash[:error] = "There was an error saving the wiki. Please try again."
        render :show     
      end
  end

  def create
    @wiki = Wiki.new(wiki_params)
      #raise #this will short circuit the method and can be used for debugging
      authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end

  end

private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
