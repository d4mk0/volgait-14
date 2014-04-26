class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :rate_up]
	before_filter :find_question
  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end
  
  def rate_up
    @answer.rate_up!
    redirect_to question_path(@question)
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
    redirect_to root_path unless can? :update, @answer
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
		if @answer.save
			redirect_to question_path(@question), notice: 'Answer was successfully created.' 
		else
			render :new 
		end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    redirect_to root_path unless can? :update, @answer
    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: 'Answer was successfully created.' 
    else
      render :new 
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    redirect_to root_path unless can? :destroy, @answer
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question_path(@question) }
      format.json { head :no_content }
    end
  end

  private
	
	def find_question
		@question = Question.find(params[:question_id])
	end
  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:text)
  end
end
