require "test_helper"

describe Task do
  describe "task expiry" do
    subject { Task.new(created_at: 7.days.ago) }
    it "must show the task as expired if the created_at is > 7.days and
        the completed_at is nil" do
      subject.expired?.must_equal true
    end
  end
end
