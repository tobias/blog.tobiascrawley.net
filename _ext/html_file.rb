require 'awestruct/front_matter_file'

module Awestruct
  class HtmlFile < FrontMatterFile

    def initialize(site, source_path, relative_source_path, options = {})
      super(site, source_path, relative_source_path, options)
    end

    def output_filename
      File.basename( self.source_path, '.html' )
    end

    def output_extension
      File.extname( output_filename )
    end

    def content
      site.engine.create_context( self )
    end
  end
end
