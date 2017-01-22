require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "task_created" do
    mail = NoticeMailer.task_created
    assert_equal "Task created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
