require 'spec_helper'

describe Question do
  before do
    @user = User.new
    @user.email = 'mail@example.com'
    @user.password = 'password'
    @user.save
    @question = Question.create(title: 'question', text: 'text', user: @user)
  end
  it 'should create question' do
    expect{Question.create(title: 'title', text: 'text', user: @user)}.to change{Question.count}.by(1)
  end
  
  it 'shouldnt create question without title & text' do
    expect{Question.create}.to change{Question.count}.by(0)
  end
  
  it 'shouldnt create question with empty text' do
    expect{Question.create(title: 'title', text: '', user: @user)}.to change{Question.count}.by(0)
  end
  
  it 'shouldnt create question with empty title' do
    expect{Question.create(title: '', text: 'text', user: @user)}.to change{Question.count}.by(0)
  end
  
  it 'shouldnt create question without user' do
    expect{Question.create(title: 'title', text: 'text')}.to change{Question.count}.by(0)
  end
  
  it 'should make rateup' do
    old = @question.rate
    @question.rate_up!
    (@question.rate-old).should == 1
  end
  
  it 'should make ratedown' do
    old = @question.rate
    @question.rate_down!
    (@question.rate-old).should == -1
  end
  
  it 'should change visitors count' do
    old = @question.views
    @question.visit!
    (@question.views-old).should == 1
  end
end
