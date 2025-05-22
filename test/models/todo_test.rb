require "test_helper"

class TodoTest < ActiveSupport::TestCase
  def setup
    @todo = Todo.new(
      title: "Test Todo",
      description: "This is a test todo",
      status: "pending"
    )
  end

  test "should be valid" do
    assert @todo.valid?
  end

  test "title should be present" do
    @todo.title = nil
    assert_not @todo.valid?
    assert_includes @todo.errors[:title], "can't be blank"
  end

  test "status should be present" do
    @todo.status = nil
    assert_not @todo.valid?
    assert_includes @todo.errors[:status], "can't be blank"
  end

  test "status should be valid" do
    @todo.status = "invalid_status"
    assert_not @todo.valid?
    assert_includes @todo.errors[:status], "is not included in the list"
  end

  test "description should not be too long" do
    @todo.description = "a" * 501
    assert_not @todo.valid?
    assert_includes @todo.errors[:description], "is too long (maximum is 500 characters)"
  end

  test "should accept valid status values" do
    valid_statuses = %w[pending in_progress completed]
    valid_statuses.each do |status|
      @todo.status = status
      assert @todo.valid?, "#{status} should be valid"
    end
  end
end 