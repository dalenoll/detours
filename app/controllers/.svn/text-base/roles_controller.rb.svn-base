class RolesController < ApplicationController
  # GET /roles
  # GET /roles.xml
  def index
    @roles = Role.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    @role = Role.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = Role.new

    rights = ControllersAndAction.find(:all, :order => "controller,action")
    @available_rights = Array.new

    rights.each do |right| 
      logger.info("NEW: Generating available right for " + right.name + "\n")
      @available_rights << RightList.new(right.name, 0)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])

    rights = ControllersAndAction.find(:all, :order => "controller,action")
    @available_rights = Array.new

    rights.each do |right| 
      logger.info("EDIT: Generating available right for " + right.name + "\n")
      grant = 0
      @role.rights.each do |role_right|
        if role_right.name == right.name
          grant = 1
        end
      end
      if grant == 1
        @available_rights << RightList.new(right.name, 1)
        logger.info("     Right had been granted\n")
      else
        @available_rights << RightList.new(right.name, 0)
        logger.info("     Right had NOT been granted\n")
      end
    end

  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])

    ar = params[:@available_rights]
    ar.each_value do |right|
      logger.info("create: right " + right[:right_name] + " = " + right[:right_allowed] + "\n")
      if right[:right_allowed].to_i == 1
        ca = ControllersAndAction.find_by_name(right[:right_name])
        if ca
          @role.rights <<  Right.create( :name => ca.name, :controller => ca.controller, :action => ca.action )
          logger.info("Creating right " + ca.name + "\n")
        else
          logger.info("Error: Cannot find " + right[:right_name] + "in ControllersAndActions\n")
        end
      else
        logger.info("   Right not created\n")
      end
    end

    respond_to do |format|
      if @role.save
        flash[:notice] = 'Role was successfully created.'
        format.html { redirect_to(:action => :index) }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = Role.find(params[:id])

    ar = params[:@available_rights]
    ar.each_value do |right|
      logger.info("create: right " + right[:right_name] + " = " + right[:right_allowed] + "\n")
      if right[:right_allowed].to_i == 1
        if @role.rights.find_by_name(right[:right_name])
          logger.info("Right already granted. No change\n")
        else 
          ca = ControllersAndAction.find_by_name(right[:right_name])
          if ca
            @role.rights <<  Right.create( :name => ca.name, :controller => ca.controller, :action => ca.action )
            logger.info("granting right " + ca.name + "\n")
          else
            logger.info("Error: Cannot find " + right[:right_name] + "in ControllersAndActions\n")
          end
        end
      else # right not requested
        ca = @role.rights.find_by_name(right[:right_name])
        if ca
          logger.info("   Right was granted... revoking\n")
          ca.destroy
        else
          logger.info("   Right had not been granted\n")
        end
      end
    end

    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = 'Role was successfully updated.'
        format.html { redirect_to(:action => :index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role = Role.find(params[:id])

    # Destroy the rights for this role
    @role.rights.each do |r|
      r.destroy
    end
    # destroy the role
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
      format.xml  { head :ok }
    end
  end

end
