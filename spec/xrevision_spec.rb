require 'fileutils'
require 'rack/builder'
require 'rack/mock'
require_relative '../lib/rack-xrevision'

describe Rack::Xrevision do
  let(:app_path) { "/tmp/test_app_#{Time.now.to_i}" }
  let(:app) {
    lambda { |env| [200, {}, ['hello, this is dog']] }
  }

  before do
    FileUtils.mkdir app_path
  end

  after do
    FileUtils.remove_dir app_path
  end

  let(:env) { Hash.new }

  it 'checks if X-Rev header is present' do
    path = app_path
    app = Rack::Builder.new do
      use Rack::Xrevision, :app_path => path
      run lambda { |env|
        [
          200,
          { 'Content-Type' => 'text/html' },
          ["<html><head></head><body>Hello, yes this is dog</body></html>"]
        ]
      }
    end
    response = Rack::MockRequest.new(app).get('/')

    response.headers.should include('X-Rev')
  end

  context 'when there is a REVISION file' do
    let(:xrevision) { Rack::Xrevision.new(app, :app_path => app_path) }
    let(:rev_id) { "ff9429886dd39e4c765881673de9ca8c5bdb6f84" }
    let(:revision_file_path) { "#{app_path}/REVISION" }

    before do
      File.open(revision_file_path, 'w') do |file|
        file.write rev_id
      end
    end

    it 'adds x-commit-id header to response' do
      status, headers, body = xrevision.call(env)
      headers['X-Rev'].should_not be_nil
      headers['X-Rev'].should == rev_id
    end
  end

  context 'when there is no REVISION file' do
    let(:xrevision) { Rack::Xrevision.new(app, :app_path => app_path) }

    context 'and app is not in git repo' do
      it 'doesn\' add X-commit-id header' do
        status, headers, body = xrevision.call(env)
        headers['X-Rev'].should == ''
      end
    end

    context 'and app is in git repo' do
      before do
        Dir.chdir app_path do
          `git init && touch foo && git add . && git commit -m 'initial commit'`
          @rev_id = %x[git rev-list master | head -n 1]
        end
      end

      it 'call git command to get latest commit id' do
        status, headers, body = xrevision.call(env)
        headers['X-Rev'].should == @rev_id
      end
    end
  end
end
