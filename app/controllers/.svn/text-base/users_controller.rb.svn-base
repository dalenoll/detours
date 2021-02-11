class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all,:conditions => "username <> 'notloggedin'", :order => :username)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    roles = Role.find(:all, :order => "name")
    @available_roles = Array.new

    roles.each do |role|
      logger.info("NEW: Generating available role for " + role.name + "\n")
      @available_roles << RoleList.new(role.name, 0)
    end


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    logger.info("\nEDIT: Calling for id: " + params[:id] + " User: " + @user.username + "\n\n")

    if params[:id] == "0"
      respond_to do |format|
        flash[:notice] = "User #{@user.username} cannot be updated."
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    end

    roles = Role.find(:all, :order => "name")
    @available_roles = Array.new

    roles.each do |role|
      logger.info("EDIT: Generating available role for " + role.name + "\n")
      grant = 0
      @user.roles.each do |user_role|
        if user_role.name == role.name
          grant = 1
        end
      end
      if grant == 1
        @available_roles << RoleList.new(role.name, 1)
        logger.info("     Role had been granted\n")
      else
        @available_roles << RoleList.new(role.name, 0)
        logger.info("     Role had NOT been granted\n")
      end
    end

 
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    ar = params[:@available_roles]
    ar.each_value do |role|
      logger.info("create: role " + role[:role_name] + " = " + role[:role_allowed] + "\n")
      if role[:role_allowed].to_i == 1
        ca = Role.find_by_name(role[:role_name])
        if ca
          @user.roles <<  ca
          logger.info("assigning role " + ca.name + "\n")
        else
          logger.info("Error: Cannot find " + role[:role_name] + "in Roles\n")
        end
      else
        logger.info("   Role not assigned\n")
      end
    end
 
    respond_to do |format|
      if @user.save
        flash[:notice] = "User #{@user.username} was successfully created."
        format.html { redirect_to(:action => :index) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        roles = Role.find(:all, :order => "name")
        @available_roles = Array.new

        roles.each do |role|
          @available_roles << RoleList.new(role.name, 0)
        end

        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    if params[:id] == "0"
      respond_to do |format|
        flash[:notice] = "User #{@user.username} cannot be updated."
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    end

    ar = params[:@available_roles]
    ar.each_value do |role|
      logger.info("create: role " + role[:role_name] + " = " + role[:role_allowed] + "\n")
      if role[:role_allowed].to_i == 1
        if @user.roles.find_by_name(role[:role_name])
          logger.info("Role already granted. No change\n")
        else
          ca = Role.find_by_name(role[:role_name])
          if ca
            @user.roles << ca
            logger.info("granting role " + ca.name + "\n")
          else
            logger.info("Error: Cannot find " + role[:role_name] + "in Roles\n")
          end
        end
      else # role not requested
        ca = @user.roles.find_by_name(role[:role_name])
        if ca
          logger.info("   Role was granted... revoking\n")
          @user.roles.delete(ca)
          # ca.destroy
        else
          logger.info("   Role had not been granted\n")
        end
      end
    end


    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User #{@user.username} was successfully updated."
        format.html { redirect_to(:action => :index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    if params[:id] == "0" or @user.username == "notloggedin"
      respond_to do |format|
        flash[:notice] = "User #{@user.username} cannot be deleted."
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    end

  end

  def has_controller_access(requested_controller)

    # Get the current user
    user = User.find_by_id(session[:userid])
    if user
      if user.roles.rights.find_by_controller_name(requested_controler, :limit => 1)
        true
      else
        false
      end
    else
      false
    end
  end  
end
