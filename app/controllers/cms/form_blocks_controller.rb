module Cms
  class FormBlocksController < Cms::ContentBlockController

    protected



    def build_block
      if params[:type].blank?
       # @block = model_class.new
      else
       # @block = params[:type].classify.constantize.new(params[params[:type]])
      end
    end

    def update_block
      #load_block
      #@block.update_attributes(params[@block.class.name.underscore])
    end



    def block_path(block, action=nil)
      #send("#{action ? "#{action}_" : ""}portlet_path", block)
    end


  end
end