class DropletsController < ApplicationController
  
  # GET /droplets
  # GET /droplets.json
  def index
    @droplets = Droplet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @droplets }
    end
  end

  # GET /droplets/1
  # GET /droplets/1.json
  def show
    @droplet = Droplet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @droplet }
    end
  end

  # GET /droplets/new
  # GET /droplets/new.json
  def new
    @droplet = Droplet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @droplet }
    end
  end

  # GET /droplets/1/edit
  def edit
    @droplet = Droplet.find(params[:id])
  end

  # POST /droplets
  # POST /droplets.json
  def create
    @droplet = Droplet.new(params[:droplet])
    @droplet.user ||= current_user
    @droplet.status ||= Status.find_by_name("pending")

    respond_to do |format|
      if @droplet.save
        format.html { redirect_to @droplet, notice: 'Droplet was successfully created.' }
        format.json { render json: @droplet, status: :created, location: @droplet }
      else
        format.html { render action: "new" }
        format.json { render json: @droplet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /droplets/1
  # PUT /droplets/1.json
  def update
    @droplet = Droplet.find(params[:id])
	@droplet.user ||= current_user

    respond_to do |format|
      if @droplet.update_attributes(params[:droplet])
        format.html { redirect_to @droplet, notice: 'Droplet was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @droplet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /droplets/1
  # DELETE /droplets/1.json
  def destroy
    @droplet = Droplet.find(params[:id])
	@droplet.user = current_user
    @droplet.status = Status.find_by_name("removed")
    @droplet.save

    respond_to do |format|
      format.html { redirect_to droplets_url }
      format.json { head :ok }
    end
  end
  
  def pending
    downloaded_id = Status.find_by_name("downloaded").id
	synched_id = Status.find_by_name("synched").id
    droplets = Droplet.select([:id, :name]).where(:status_id => [downloaded_id, synched_id], :user_id => current_user.id).all
	render :json => {:droplets => droplets}.to_json
  rescue
    render :text => "error"
  end
  
  def synch
	downloaded_id = Status.find_by_name("downloaded").id
	synched_id = Status.find_by_name("synched").id
    droplet = Droplet.where(:id => params[:id], :user_id => current_user.id, :status_id => [downloaded_id, synched_id]).first
	raise if droplet.nil?
	droplet.update_status("synched")
	send_file droplet.file, :x_sendfile=>true
  rescue
    render :text => "error"
  end
  
  def confirm
    droplet = Droplet.where(:id => params[:id], :user_id => current_user.id, :status_id => Status.find_by_name("synched").id).first
	raise if droplet.nil?
	droplet.update_status("removed")
	File.delete(droplet.file)
	droplet.file = ""
	render :text => "ok"
  rescue
    render :text => "error"
  end
  
  def upload
	@droplet = Droplet.new()
    @droplet.user = current_user
	if params.has_key? :force
		params.each{|param| @file = param[1] if param[1].is_a? ActionDispatch::Http::UploadedFile }
		@droplet.upload(params[:name], @file)
	else
		@droplet.upload(params[:name], params[:data])
	end
	@droplet.status = Status.find_by_name("downloaded")
	render :text => "ok"
  rescue
    render :text => "error"
  end
  
end
