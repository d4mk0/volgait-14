class ManageController < ApplicationController
  def index
    @questions = current_user.questions.not_drafts
    @answers = current_user.answers
    @drafts = current_user.questions.drafts
  end
end
