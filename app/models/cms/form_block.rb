module Cms
  class FormBlock  < ActiveRecord::Base

    acts_as_content_block :taggable => true

    #attr_accessible :name, :content

    #validates_presence_of :name

    def self.display_name
      "Form"
    end
  end

end
