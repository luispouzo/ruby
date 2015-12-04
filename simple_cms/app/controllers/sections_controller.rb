class SectionsController < ApplicationController
	layout "admin"
	
	before_action :confirm_logged_in
  	before_action :find_page

	def index
		@sections = @page.sections.sorted
		respond_to do |format|
			format.html
		end
	end

	def show
		@section = get_section
	end

	def new
		@section = Section.new(page_id: @page.id)
		@pages = @page.subject.pages.sorted
		@section_count = Section.count + 1
	end

	def edit
		@section = get_section
		@pages = @page.subject.pages.sorted
		@section_count = Section.count
	end

	def create
		@section = Section.new(section_params)
		respond_to do |format|
			if @section.save
				format.html {
					flash[:notice] = "Section '#{@section.name}' has been successfully created."
					redirect_to action: :index, page_id: @page.id, notice: "Section '#{@section.name}' has been successfully created."
				}
			else
				format.html {
					@pages = @page.subject.pages.sorted
					@section_count = Section.count
					render :new
				}
			end
		end
	end

	def update
		@section = get_section
		respond_to do |format|
			if @section.update(section_params)
				format.html {
					flash[:notice] = "Section '#{@section.name}' has been successfully updated."
					redirect_to action: :index, page_id: @page.id, notice: "Section '#{@section.name}' has been successfully updated."
				}		
			else
				format.html{
					@section_count = Section.count
					render :edit
				}				
			end
		end	
	end

	def delete
		@section = get_section	
	end

	def destroy
		section = get_section
		section.destroy
		respond_to do |format|
			format.html{
				flash[:notice] = "Section '#{@section}' has been successfully destroyed."
				redirect_to action: :index, page_id: @page.id, notice: "Section '#{@section}' has been successfully destroyed."
			}
		end
	end

	private
		def section_params
			params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
		end

		def get_section
			Section.find(params[:id])
		end
		def find_page
	      if params[:page_id]
	        @page = Page.find(params[:page_id])
	      end
	    end

end
