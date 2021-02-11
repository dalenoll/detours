class DetoursController < ApplicationController
  # GET /detours
  # GET /detours.xml
  def index
    # @detours = Detour.find(:all)
    @detours = Detour.find_active_detours

    respond_to do |format|
      format.html # index.html.erb
      # format.xml  { render :xml => @detours }
      format.xml  
      format.json { render :json => @detours }
    end
  end

  def index_by_date
    # @detours = Detour.find(:all)
    @detours = Detour.find_active_detours_by_date

    respond_to do |format|
      format.html # index.html.erb
      # format.xml  { render :xml => @detours }
      format.xml  
      format.json { render :json => @detours }
    end
  end

  # GET /detours
  # GET /detours.xml
  def inactive
    @detours = Detour.find_inactive_detours

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @detours }
    end
  end

  # GET /detours/1
  # GET /detours/1.xml
  def show
    @detour = Detour.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @detour }
    end
  end

  # GET /detours/show_inactive/1
  def show_inactive
    @detour = Detour.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /detours/new
  # GET /detours/new.xml
  def new
    @detour = Detour.new

    @detour.dispatcher = User.find_by_id(session[:userid]).full_name

    @locations = Location.find(:all)
    @nrs = Array.new
    @locations.each do |l|
      @nrs.push( NotificationRequest.new(l.id, l.short_name, l.long_name, l.notify_by_default))
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @detour }
    end
  end

  # GET /detours/1/edit
  def edit
    @detour = Detour.find(params[:id])
  end

  # POST /detours
  # POST /detours.xml
  def create

    @detour = Detour.new(params[:detour])

    @detour.create_addr = request.remote_ip
    @detour.canceled = nil

    respond_to do |format|
      if @detour.save
        my_nrs = params[:@nrs]
        logger.info("Detours.create - Adding notifications\n")
        my_nrs.each_value do | nr |
          logger.info("Notification for location_id = " + nr[:location_id] + "\n")
          logger.info("     notify = " + nr[:notify] + "\n")
          logger.info("     acknowledge = " + nr[:acknowledge] + "\n")
          if nr[:notify].to_i == 1 
            # Look up the location and get the notification methods
            location = Location.find(nr[:location_id])
            logger.info("     Location " + nr[:location_id] + " is known as " + location.long_name + "\n")
            if location.fax_default == 1 && ! location.fax_number.blank?
              notification = Notification.create(
                  :detour_id    =>  @detour.id,
                  :location_id  =>  nr[:location_id],
                  :notification_type  =>  "DETON",
                  :notification_method => "FAX",
                  :acknowledge_requested => nr[:acknowledge]
                  )
            end
            if location.email_default == 1 && ! location.email_address.blank?
              notification = Notification.create(
                  :detour_id    =>  @detour.id,
                  :location_id  =>  nr[:location_id],
                  :notification_type  =>  "DETON",
                  :notification_method => "EMAIL",
                  :acknowledge_requested => nr[:acknowledge]
                  )
            end
            if location.printer_default == 1 && ! location.printer.blank?
              notification = Notification.create(
                  :detour_id    =>  @detour.id,
                  :location_id  =>  nr[:location_id],
                  :notification_type  =>  "DETON",
                  :notification_method => "PRINTER",
                  :acknowledge_requested => nr[:acknowledge]
                  )
            end
            if location.phone_default == 1 && ! location.phone_number.blank?
              notification = Notification.create(
                  :detour_id    =>  @detour.id,
                  :location_id  =>  nr[:location_id],
                  :notification_type  =>  "DETON",
                  :notification_method => "PHONE",
                  :acknowledge_requested => nr[:acknowledge]
                  )
            end
          else
            logger.info("  NO Notification requested for this location")
          end
        end
        flash[:notice] = 'Detour was successfully created.'
        format.html { redirect_to(detours_url) }
        format.xml  { render :xml => @detour, :status => :created, :location => @detour }
      else
        @locations = Location.find(:all)
        @nrs = Array.new
        @locations.each do |l|
          @nrs.push( NotificationRequest.new(l.id, l.short_name, l.long_name, l.notify_by_default))
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @detour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /detours/1
  # PUT /detours/1.xml
  def update
    @detour = Detour.find(params[:id])

    @detour.change_addr = request.remote_ip
    @detour.change_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    respond_to do |format|
    	if @detour.update_attributes(params[:detour])
        	flash[:notice] = 'Detour was successfully updated.'

		@detour.change_pdf_path = nil
		@detour.save
		@detour.notifications.each do |n|
			next if n.notification_type != 'DETON'
			@new_not = Notification.new
			@new_not.detour_id = n.detour_id
			@new_not.location_id = n.location_id
			@new_not.notification_method = n.notification_method
			@new_not.notification_type = 'DETCHG'
			@new_not.acknowledge_requested = n.acknowledge_requested
			@new_not.save
	   	end

        format.html { redirect_to(detours_url) }
        # format.html { redirect_to(@detour) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @detour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /detours/1
  # DELETE /detours/1.xml
  def destroy
    @detour = Detour.find(params[:id])
    @detour.notifications.each do |n|
      logger.info("Deleteing notification " + n.id.to_s + " for detour " + @detour.id.to_s + "\n")
      n.destroy
    end
    @detour.destroy

    respond_to do |format|
      format.html { redirect_to(detours_url) }
      format.xml  { head :ok }
    end
  end

  # cancel_detour /detours/1
  # cancel_detour /detours/1.xml
  def cancel_detour
    @detour = Detour.find(params[:id])

    @detour.cancel_addr = request.remote_ip
    @detour.cancel_date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @detour.canceled = 1
    if @detour.end_date.nil?
		@detour.end_date = Time.now.strftime("%Y-%m-%d")
    	@detour.end_time = Time.now.strftime("%H:%M:%S")
	end

    if @detour.update_attributes(params[:detour])
        flash[:notice] = 'Detour marked as canceled.'

	@detour.notifications.each do |n|
		next if n.notification_type != 'DETON'
		@new_not = Notification.new
		@new_not.detour_id = n.detour_id
		@new_not.location_id = n.location_id
		@new_not.notification_method = n.notification_method
		@new_not.notification_type = 'DETOFF'
		@new_not.acknowledge_requested = n.acknowledge_requested
		@new_not.save
    	end
    end

    respond_to do |format|
      format.html { redirect_to(detours_url) }
    end
  end

protected

  def authorize
  end
end
