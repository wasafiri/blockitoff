require "test_helper"

describe Task do
  describe "task completion" do
    subject { Task.new(description: "do some stuff", created_at: Time.now) }

    it "must show the task as being marked complete" do
      expect (subject.completed_at).to be_nil
      visit_task task
        click_link "Mark Complete"
    end
    task.reload
    expect(subject.completed_at.to_not be_nil)
  end
end
