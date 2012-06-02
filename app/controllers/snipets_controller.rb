class SnipetsController < ApplicationController
  # GET /snipets
  # GET /snipets.json
  def index
    @snipets = Snipet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @snipets }
    end
  end

  # GET /snipets/1
  # GET /snipets/1.json
  def show
    @snipet = Snipet.find(params[:id])
    begin
      @data = eval(@snipet.query)
      begin
        @table_recods = @data.map{|r| r.map{|x| "<td>#{x}</td>" }.join() }.map{|r| "<tr>#{r}</tr>"}.join
      rescue
        @table_records = ""
        flash[:notice] = "Format Error."
      end 
    rescue TypeError
      @data = []
      flash[:notice] = "Type Error."
    rescue NameError
      @data = []
      flash[:notice] = "Name Error."
    rescue SyntaxError
      @data = []
      flash[:notice] = "Syntax Error."
    end 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @snipet }
    end
  end

  # GET /snipets/new
  # GET /snipets/new.json
  def new
    @snipet = Snipet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @snipet }
    end
  end

  # GET /snipets/1/edit
  def edit
    @snipet = Snipet.find(params[:id])
  end

  # POST /snipets
  # POST /snipets.json
  def create
    @snipet = Snipet.new(params[:snipet])

    respond_to do |format|
      if @snipet.save
        format.html { redirect_to @snipet, notice: 'Snipet was successfully created.' }
        format.json { render json: @snipet, status: :created, location: @snipet }
      else
        format.html { render action: "new" }
        format.json { render json: @snipet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /snipets/1
  # PUT /snipets/1.json
  def update
    @snipet = Snipet.find(params[:id])

    respond_to do |format|
      if @snipet.update_attributes(params[:snipet])
        format.html { redirect_to @snipet, notice: 'Snipet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @snipet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snipets/1
  # DELETE /snipets/1.json
  def destroy
    @snipet = Snipet.find(params[:id])
    @snipet.destroy

    respond_to do |format|
      format.html { redirect_to snipets_url }
      format.json { head :no_content }
    end
  end
end
