require "test_helper"

#change this to an integration test

describe Task do
  # context 'scopes' do
    describe "task expiry" do
      subject { Task.new(created_at: 9.days.ago) }
      it "must show the task as expired if the created_at is > 7.days" do
        subject.active.must_equal true
      end
    end
  # end
  describe "task creation via webpage" do
    #visit the webpage as {user}
    #fill out form and click button to create new task
    #task creation must be successful
  end
  describe "task creation via json" do
    #send json to create new task as {user}
    #task creation must be successful
  end
end
