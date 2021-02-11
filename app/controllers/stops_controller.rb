class StopsController < ApplicationController
  # GET /stops
  # GET /stops.xml
  def index
    @stops = Stops.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stops }
    end
  end

  # GET /stops/1
  # GET /stops/1.xml
  def show
    @stops = Stops.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stops }
    end
  end

  # GET /stops/new
  # GET /stops/new.xml
  def new
    @stop = Stops.new

    @stop.dispatcher = User.find_by_id(session[:userid]).full_name

    @locations = Location.find(:all)
    @nrs = Array.new
    @locations.each do |l|
      @nrs.push( NotificationRequest.new(l.id, l.short_name, l.long_name, l.notify_by_default))
    end


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stops }
    end
  end

  # GET /stops/1/edit
  def edit
    @stops = Stops.find(params[:id])
  end

  # POST /stops
  # POST /stops.xml
  def create
    @stops = Stops.new(params[:stops])

    respond_to do |format|
      if @stops.save
        flash[:notice] = 'Stops was successfully created.'
        format.html { redirect_to(@stops) }
        format.xml  { render :xml => @stops, :status => :created, :location => @stops }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stops.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stops/1
  # PUT /stops/1.xml
  def update
    @stops = Stops.find(params[:id])

    respond_to do |format|
      if @stops.update_attributes(params[:stops])
        flash[:notice] = 'Stops was successfully updated.'
        format.html { redirect_to(@stops) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stops.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stops/1
  # DELETE /stops/1.xml
  def destroy
    @stops = Stops.find(params[:id])
    @stops.destroy

    respond_to do |format|
      format.html { redirect_to(stops_url) }
      format.xml  { head :ok }
    end
  end
end
