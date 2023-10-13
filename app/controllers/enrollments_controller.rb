class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]
  before_action :set_course, only: [:new, :create]

  # GET /enrollments or /enrollments.json
  def index
    @enrollments = Enrollment.all
    # authorize @enrollments
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  # We don't need to edit. -miki 2023-10-13
  # def edit
  #   authorize @enrollment
  # end

  # POST /enrollments or /enrollments.json
  def create()
    @course = Course.find(params[:course_id])
    puts "In create."
    if @course.price > 0
      puts "if @course.price > 0"
      flash[:alert] = "You cannot access paid courses yet."
      redirect_to new_enrollment_path(@course)
    else
      puts "else"
      @enrollment = current_user.buy_course(@course)
      redirect_to course_path(@course), notice: "Enrollment successful!"
    end
    # @enrollment = Enrollment.new(enrollment_params)
    # @enrollment.price = @enrollment.course.price

    # respond_to do |format|
    #   if @enrollment.save
    #     format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully created." }
    #     format.json { render :show, status: :created, location: @enrollment }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @enrollment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    authorize @enrollment
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    authorize @enrollment
    @enrollment.destroy

    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      puts "The params[:course_id] is: #{params[:course_id]}"
      @course = Course.find(params[:course_id])
      puts "The course is: #{@course}"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:course_id, :user_id, :rating, :review)
    end
end
