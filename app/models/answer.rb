class Answer < ActiveRecord::Base
	belongs_to :question
  validates_presence_of :text, :user, :question
  belongs_to :user
  scope :cronological, -> {order 'created_at DESC'}
  
  def rate_up!
    update_attributes rate: rate+1
  end
end
