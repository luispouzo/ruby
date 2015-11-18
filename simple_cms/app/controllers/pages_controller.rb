class PagesController < ApplicationController
  layout "admin"

  def index
    @pages = Page.sorted
  end

  def show
    @page = get_page
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to action: :index, notice: 'Page #{page.name} has been successfully created'
    else
      render :new
    end
  end

  def edit
    @page = get_page
  end

  def update
    @page = get_page
    if @page.update(page_params)
      redirect_to action: :index, notice: 'Page #{page.name} has been successfully updated'
    else
      render :edit
    end
  end

  def delete
    @page = get_page
  end

  def destroy
    @page.destroy
    redirect_to action: :index, notice: 'Page #{page.name} has been successfully destroyed'
  end

  private

    def get_page
      Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:name, :position, :visible, :permalink)
    end
end
