class ControllersAndActionsController < ApplicationController
  # GET /controllers_and_actions
  # GET /controllers_and_actions.xml
  def index
    @controllers_and_actions = ControllersAndAction.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @controllers_and_actions }
    end
  end


  # GET /controllers_and_actions/new
  # GET /controllers_and_actions/new.xml
  def new
    @controllers_and_action = ControllersAndAction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @controllers_and_action }
    end
  end

  # GET /controllers_and_actions/1/edit
  def edit
    @controllers_and_action = ControllersAndAction.find(params[:id])
  end

  # POST /controllers_and_actions
  # POST /controllers_and_actions.xml
  def create
    @controllers_and_action = ControllersAndAction.new(params[:controllers_and_action])

    respond_to do |format|
      if @controllers_and_action.save
        flash[:notice] = 'Controller and Action was successfully created.'
        format.html { redirect_to(:action => :new) }
        format.xml  { render :xml => @controllers_and_action, :status => :created, :location => @controllers_and_action }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @controllers_and_action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /controllers_and_actions/1
  # PUT /controllers_and_actions/1.xml
  def update
    @controllers_and_action = ControllersAndAction.find(params[:id])

    respond_to do |format|
      if @controllers_and_action.update_attributes(params[:controllers_and_action])
        flash[:notice] = 'Controller and Action was successfully updated.'
        format.html { redirect_to(:action => :index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @controllers_and_action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /controllers_and_actions/1
  # DELETE /controllers_and_actions/1.xml
  def destroy
    @controllers_and_action = ControllersAndAction.find(params[:id])
    @controllers_and_action.destroy

    respond_to do |format|
      format.html { redirect_to(controllers_and_actions_url) }
      format.xml  { head :ok }
    end
  end
end
