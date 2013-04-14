module Cms
  class FormBlocksController < Cms::ContentBlockController

    protected
    def load_blocks
      @blocks = FormBlock.search(params[:search]).paginate(
          :page => params[:page],
          :order => params[:order] || "name",
          :conditions => ["deleted = ?", false]
      )
    end

    def build_block
      if params[:type].blank?
        @block = model_class.new
      else
        @block = params[:type].classify.constantize.new(params[params[:type]])
      end
    end

    def update_block
      load_block
      @block.update_attributes(params[@block.class.name.underscore])
    end

    def block_form
      "form_blocks/form_blocks/form"
    end

    def new_block_path(block)
      new_form_block_path
    end

    def block_path(block, action=nil)
      send("#{action ? "#{action}_" : ""}form_block_path", block)
    end

    def blocks_path
      form_blocks_path
    end
  end
end