module UsersHelper
  # Bootstrapのform-groupの枠組みを作るヘルパー
  #
  # 使い方:
  # <%= bs_form_group messages: some_errors, type: :warning do |messages| %>
  #   ...
  #   messages.call
  #   ...
  # <% end %>
  #
  # 出力:
  # <div class="form-group has-warning">
  #   ...
  #   <div>
  #     <span class="help-block">hoge_error</span>
  #     <span class="help-block">fuga_error</span>
  #   </div>
  #   ...
  # </div>
  #
  # type:引数は:success, :warning, :errorのいずれか。デフォルトは:error
  # 任意のhtml属性は、html: {class: 'hoge'}というような引数で指定可能。
  #
  def bs_form_group(messages: nil, type: 'error', html: {}, &block)
    if html[:class].nil?
      html[:class] = []
    elsif html[:class].kind_of?(String)
      html[:class] = html[:class].split(' ')
    end
    html[:class] << 'form-group'
    html[:class] << "has-#{type}" unless messages.blank?
    output = capture(-> { bs_form_messages(messages) }, &block)
    content_tag :div, output, html
  end

  private
  # Bootstrapのスタイルでフォームグループごとのメッセージを列挙する
  def bs_form_messages(messages)
    return if messages.blank?
    messages = Array(messages) unless messages.kind_of?(Array)

    content_tag :div do
      messages.each do |m|
        concat content_tag(:span, m, class: 'help-block')
      end
    end
  end
end
