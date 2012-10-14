module Rack
  class Xrevision
    REVISION_FILE_NAME = 'REVISION'
    def initialize(app, options={})
      @app = app
      @app_path = options[:app_path] || Dir.pwd
      @revision_file_name = options[:file_name] || REVISION_FILE_NAME
    end

    def call(env)
      status, headers, response = @app.call(env)
      headers['X-Rev'] = rev_id if rev_id
      [status, headers, response]
    end

    def rev_id
      @rev_id ||= begin
        load_from_file || load_from_git
      end
    end

    def revision_file_path
      "#{@app_path}/#{@revision_file_name}"
    end

    private
    def load_from_file
      return nil unless File.exists?(revision_file_path)

      File.read(revision_file_path)
    end

    def load_from_git
      return '' unless system('which git 1> /dev/null')

      Dir.chdir @app_path do
        %x[(git rev-list master | head -n 1) 2> /dev/null]
      end
    end
  end
end
