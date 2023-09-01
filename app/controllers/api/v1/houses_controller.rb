class Api::V1::HousesController < ApplicationController
  # load_and_authorize_resource
  before_action :set_house, only: %i[show edit update destroy]

  # GET /houses or /houses.json
  def index
    @houses = House.all
    render json: @houses
  end

  # GET /houses/1 or /houses/1.json
  def show; end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit; end

  # POST /houses or /houses.json
  def create
    @house = House.new(house_params)

    if @house.save
      render json: { status: 'success', message: 'House created successfully!' }, status: :created
    else
      render json: { status: 'failed', errors: @house.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /houses/1 or /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to house_url(@house), notice: 'House was successfully updated.' }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1 or /houses/1.json
  def destroy
    @house.destroy

    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def unique_cities
    cities = House.distinct.pluck(:city)
    render json: cities
  end

  def unique_houses
    houses = House.distinct.pluck(:house_name)
    render json: houses
  end

  # GET /houses/1 or /houses/1.json
  swagger_path '/houses/{id}' do
    operation :get do
      key :summary, 'Fetch a house by ID'
      key :tags, ['Houses']
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of the house'
        key :required, true
        key :type, :integer
      end
      response 200 do
        key :description, 'House response'
        schema do
          key :type, :object
          key :$ref, :House
        end
      end
      response 404 do
        key :description, 'House not found'
      end
    end
  end

  # POST /houses or /houses.json
  swagger_path '/houses' do
    operation :post do
      key :summary, 'Create a new house'
      key :tags, ['Houses']
      parameter do
        key :name, :house
        key :in, :body
        key :description, 'House parameters'
        key :required, true
        schema do
          key :$ref, :HouseInput
        end
      end
      response 201 do
        key :description, 'House created successfully'
        schema do
          key :type, :object
          key :$ref, :House
        end
      end
      response 422 do
        key :description, 'Unprocessable Entity'
        schema do
          key :type, :object
          property :status do
            key :type, :string
            key :example, 'failed'
          end
          property :errors do
            key :type, :array
            items do
              key :type, :string
            end
          end
        end
      end
    end
  end

  private

  def set_house
    @house = House.find(params[:id])
  end

  def house_params
    params.require(:house).permit(:icon, :house_name, :city, :description, :bedrooms, :bathrooms, :rent, :security_deposit, :contact_phone_number, :admin_user_id)
  end

  swagger_schema :House do
    key :required, %i[id house_name city description bedrooms bathrooms rent security_deposit contact_phone_number admin_user_id]
    property :id do
      key :type, :integer
    end
  end

  swagger_schema :HouseInput do
    key :required, %i[house_name city description bedrooms bathrooms rent security_deposit contact_phone_number admin_user_id]
    property :house_name do
      key :type, :string
    end
  end
end
