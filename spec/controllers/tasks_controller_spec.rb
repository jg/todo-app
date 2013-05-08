require 'spec_helper'

describe "Tasks", :type => :request do
  json =  '{"task": {"priority":"High","completed_at":"nil","task_list":"Inbox","due_time":"nil","due_date":"2013-03-02T00:00:00.000","created_at":"2013-03-02T16:22:57.878","repeat":"NotSet","title":"go to worclove.rb","updated_at":"2013-03-02T16:22:57.878"}}'

  before(:all) do
    u = User.new
    u.email = 'juliusz.gonera@gmail.com'
    u.encrypted_password = Digest::SHA1.hexdigest('testtest')
    u.save!
  end

  before(:each) do
    login
  end

  it "should accept task json" do
    # get(:index, :format => :json)
    # expect(response.code).to eq(200)
    response = post('/tasks', json, 'CONTENT-TYPE' => 'application/json', 'ACCEPT' => 'application/json', )
    response.status.should == 201
    Task.count.should == 1
  end

  # def raw_post(action, body, params = {:format => :json})
  #   @request.env['RAW_POST_DATA'] = body
  #   response = post(action, params, {'CONTENT-TYPE' => 'application/json', 'ACCEPT' => 'application/json'})
  #   @request.env.delete('RAW_POST_DATA')
  #   response
  # end

  # def login
  #   user = 'juliusz.gonera@gmail.com'
  #   pw = 'testtest'
  #   request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  # end
end
