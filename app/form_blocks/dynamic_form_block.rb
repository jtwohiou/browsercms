class DynamicFormBlock < Cms::FormBlock

  def render
    eval(@form_block) unless @form_block.blank?
  end

end
