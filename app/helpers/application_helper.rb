module ApplicationHelper
  def title(each_title)
    base_title = "HomeworkManager"
    if each_title.empty?
      base_title
    else
      "#{each_title} - #{base_title}"
    end
  end

  # Bootstrapのフリーアイコン(glyphicon)の表示定型文の省略メソッド
  def glyphicon(glyphicon)
    content_tag :span, '', class: "glyphicon glyphicon-#{glyphicon}", 'aria-hidden': "true"
  end
end
