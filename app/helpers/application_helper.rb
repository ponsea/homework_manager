module ApplicationHelper
  # Bootstrapのフリーアイコン(glyphicon)の表示定型文の省略メソッド
  def glyphicon(glyphicon)
    content_tag :span, '', class: "glyphicon glyphicon-#{glyphicon}", 'aria-hidden': "true"
  end
end
