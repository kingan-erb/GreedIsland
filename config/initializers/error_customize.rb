ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if instance.kind_of?(ActionView::Helpers::Tags::Label)
    html_tag.html_safe
  else
    method_name = instance.instance_variable_get(:@method_name)
    errors = instance.object.errors[method_name]
    html = <<~EOM
    <div class="field_with_errors">
      #{html_tag}
      <div class="devise-alert">
        #{I18n.t("activerecord.attributes.#{instance.object.class.name.underscore}.#{method_name}")}
        #{errors.first}
      </div>
    </div>
    EOM
    html.html_safe
  end
end