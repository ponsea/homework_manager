class NoticeMailer < ApplicationMailer
  default from: ENV['EMAIL']

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.task_created.subject
  #
  def task_created(task, to)
    @greeting = "新しいタスクが作成されました。"
    @task = task
    mail to: to, subject: '[HomeworkManager] 新しいタスクが作成されました。'
  end
end
