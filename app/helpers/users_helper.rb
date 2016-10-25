module UsersHelper
  # Bootstrapのスタイルでフォームグループごとのエラーを列挙する
  def bs_put_form_errors(errors)
    content_tag :div do
      errors.each do |e|
        concat content_tag(:span, e, class: 'help-block')
      end
    end
  end
end
