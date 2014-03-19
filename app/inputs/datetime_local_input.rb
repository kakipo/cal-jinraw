class DatetimeLocalInput < SimpleForm::Inputs::Base
  def input
    input_html_options[:type] = "datetime-local"
    # フォーマット: 2014-08-23T09:30
    dt = object.send(attribute_name)
    if dt.present?
      input_html_options[:value] = dt.strftime("%Y-%m-%dT%H:%M")
    end
    @builder.text_field(attribute_name, input_html_options)
  end
end