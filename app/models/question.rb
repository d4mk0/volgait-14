class Question < ActiveRecord::Base
#  paginates_per 5
#  max_paginates_per 5
	has_many :answers, dependent: :destroy
  belongs_to :user
	validates_presence_of :title, :text, :user
  
  scope :drafts, -> {where is_draft: true}
  scope :not_drafts, -> {where is_draft: false}
  
  scope :not_solved, -> {where is_solved: false}
  
  def publish!
    update_attributes is_draft: false
  end
  
  def solved!
    update_attributes is_solved: true
  end
  
  def rate_up!
    update_attributes rate: rate+1
  end
  
  def rate_down!
    update_attributes rate: rate-1
  end
  
  def visit!
    update_attributes views: views+1
  end
end
