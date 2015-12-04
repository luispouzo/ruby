class PagesController < ApplicationController
  layout "admin"
  before_action :confirm_logged_in
  before_action :find_subject

  def index
    @pages = @subject.pages.sorted
  end

  def show
    @page = get_page
  end

  def new
    @page = Page.new(subject_id: @subject.id)
    @subjects = Subject.sorted
    @page_count = Page.count + 1
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page '#{@page.name}' has been successfully created."
      redirect_to action: :index, subject_id: @subject.id, notice: "Page '#{@page.name}' has been successfully created."
    else
      @subjects = Subject.sorted
      @page_count = Page.count + 1
      render :new
    end
  end

  def edit
    @page = get_page
    @subjects = Subject.sorted
    @page_count = Page.count
  end

  def update
    @page = get_page
    if @page.update(page_params)
      flash[:notice] = "Page '#{@page.name}' has been successfully updated."
      redirect_to action: :index, subject_id: @subject.id, id: @page.id, notice: "Page '#{@page.name}' has been successfully updated."
    else
      @subjects = Subject.sorted
      @page_count = Page.count
      render :edit
    end
  end

  def delete
    @page = get_page
  end

  def destroy
    page = get_page.destroy
    flash[:notice] = "Page '#{page.name}' has been successfully destroyed."
    redirect_to action: :index, subject_id: @subject.id, notice: "Page '#{page.name}' has been successfully destroyed."
  end

  private

    def get_page
      Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
    end
    def find_subject
      if params[:subject_id]
        @subject = Subject.find(params[:subject_id])
      end
    end
end
