require "test_helper"

describe Task do
  describe "task expiry" do
    subject { Task.new(created_at: 7.days.ago) }
    it "must show the task as expired if the created_at is > 7.days and
        the completed_at is nil" do
      subject.expired?.must_equal true
    end
  end

  describe "task completion" do
    subject { Task.create!(description: "do some stuff", created_at: Time.now) }
    it "must show the task as being marked complete" do

      expect(subject.completed_at).to be_nil
      visit_task_path
      click_link "Mark Complete"
    end
    expect(subject.completed_at).to_not be_nil
  end
end
