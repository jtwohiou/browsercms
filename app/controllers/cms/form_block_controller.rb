module Cms
  class FormBlockController < Cms::ApplicationController

    skip_before_filter :redirect_to_cms_site
    skip_before_filter :login_required

    def execute_handler
      @form_block = FormBlock.find(params[:id])
      @form_block.controller = self

      method = params[:handler]
      if @form_block.class.superclass.method_defined?(method) or @form_block.class.private_method_defined?(method) or @form_block.class.protected_method_defined?(method)
        raise Cms::Errors::AccessDenied
      else
        redirect_to @form_block.send(method)
      end

    end

  end
end

