require 'spec_helper'

describe Answer do
  before do
    @user = User.new
    @user.email = 'mail@example.com'
    @user.password = 'password'
    @user.save
    @question = Question.create(title: 'question', text: 'text', user: @user)
    @answer = @question.answers.create(text: 'my answer', user: @user)
  end
  
  it 'should create answer for question' do
    expect{@question.answers.create(text: 'text', user: @user)}.to change{@question.answers.count}.by(1)
  end
  
  it 'should not create answer for question without text' do
    expect{@question.answers.create(user: @user)}.to change{@question.answers.count}.by(0)
  end
  
  it 'should not create answer for question without user' do
    expect{@question.answers.create(text: 'text')}.to change{@question.answers.count}.by(0)
  end
  
  it 'should make rateup' do
    old = @answer.rate
    @answer.rate_up!
    (@answer.rate-old).should == 1
  end
  
end
