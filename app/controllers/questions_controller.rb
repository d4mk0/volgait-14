class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :rate_up, :rate_down, :publish, :solved]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.not_drafts.not_solved.order('created_at DESC').page params[:page]
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question.visit!
    @answers = @question.answers.cronological
    @top_answer = Answer.where(id: @answers.pluck(:id)).order('rate DESC').first
    @answers = @answers-[@top_answer]
    @answers = [@top_answer]+@answers
  end

  # GET /questions/new
  def new
    @question = Question.new
  end
  
  def new_draft
    @question = Question.new
  end
  
  def rate_up
    @question.rate_up!
    redirect_to questions_url
  end
  
  def rate_down
    @question.rate_down!
    redirect_to questions_url
  end

  # GET /questions/1/edit
  def edit
    redirect_to root_path unless can? :update, @question
  end
  
  def publish
    redirect_to root_path unless can? :update, @question
    @question.publish!
    redirect_to manage_path, notice: 'Published!'
  end
  
  def solved
    redirect_to root_path unless can? :update, @question
    @question.solved!
    redirect_to manage_path, notice: 'Marked as solved!'
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create_draft
    @question = Question.new(question_params)
    @question.user = current_user
    @question.is_draft = true
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    redirect_to root_path unless can? :update, @question
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    redirect_to root_path unless can? :update, @question
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :text)
    end
end
