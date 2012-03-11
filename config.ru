Encoding.default_external = 'utf-8'

APP_ROOT = File.dirname(__FILE__)
require File.expand_path(File.dirname(__FILE__) + '/app')

run GithubWatcher::App
