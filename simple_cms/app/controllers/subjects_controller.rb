class SubjectsController < ApplicationController
  
	layout "admin"
  # before_action :get_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
  	@subjects = Subject.sorted
    # byebug
    respond_to do |format|
      format.html # index.html.erb
      # TODO: format.json { render json: @subjects }
   end
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @subject = get_subject
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
    @subject = get_subject
  end

  # POST /subjects
  # POST /subjects.json
  def create
  	# Instantiate a new object using form parameters
  	@subject = Subject.new(subject_params)

    respond_to do |format|
      # Save the object
      if @subject.save
        #if Save succeeds, redirect to the index action
        
        format.html { 
          flash[:notice] = 'Your subject has been successfully created.'
          redirect_to action: :index, notice: 'Your subject has been successfully created.' }
        # OLD: redirect_to action: :index, notice: 'Your subject has been successfully created.'
        # TODO: format.json { render action: :show, status: created, location: @product }
      else
        # If save fails, redisplay the form so user can fix problems
        format.html { render :new }
        # TODO: format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    # byebug
    @subject = get_subject
    respond_to do |format|
      # Save the object
      # if @subject.update_attributes(subject_params)
      if @subject.update(subject_params)
        #if update succeeds, redirect to the index action
        
        format.html { 
          flash[:notice] = 'Your subject has been successfully updated.'
          redirect_to action: :index, notice: 'Your subject has been successfully updated.' }
        # TODO: format.json { head :no_content }
      else
       # If updates fails, redisplay the form so user can fix problems
       format.html { render :edit }
       # TODO: format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @subject = get_subject
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    subject = get_subject
    subject.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = "Subject '#{subject.name}' has been successfully destryed."
        redirect_to action: :index, notice: "Subject '#{subject.name}' has been successfully destryed." }
      # TODO: format.json { head :no_content }
    end
    
  end

 	private
    # Using a private method to encapsulate the permissible parameters is
    # just a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.
  	def subject_params
  		params.require(:subject).permit(:name, :position, :visible)
  	end

    def get_subject
    # Find an existing object using form parameters
    # Use callbacks to share common setup or constraints between actions.
    Subject.find(params[:id])
  end
end
