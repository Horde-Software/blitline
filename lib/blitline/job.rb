class Blitline
  class Job
    include AttributeJsonizer
    attr_accessor :application_id, :src, :postback_url, :functions, :src_type
    SRC_TYPE_MULTI_PAGE = 'multi_page'
    def initialize(image_src, application_id = nil)
      @src = image_src
      @functions = []
    end

    def add_function(function_name, function_params, image_identifier = nil)
      function = Blitline::Function.new(function_name, function_params)
      function.add_save(image_identifier) if image_identifier
      @functions << function
      return function
    end

    def validate
      raise "Job must have an application_id" if @application_id.nil?
      raise "Job must have an image_src to work on" if @src.nil?
      raise "Vadid values for src_type are '#{SRC_TYPE_MULTI_PAGE}', nil or empty." unless @src_type.nil? || @src_type.empty? || @src_type == 'multi_page'
      @functions.each { |f| f.validate }
    end
  end
end