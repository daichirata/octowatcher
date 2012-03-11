require 'uri'
require 'json'
require 'sinatra/base'
require 'github_api'
require 'mechanize'

require 'coffee-script'
require 'haml'
require 'sass'
require 'erubis'

module GithubWatcher
  class App < Sinatra::Base
    set :haml, { :format => :html5 }

    get '/' do
      haml :index
    end

    get "/search" do
      @user = params[:user]
      redirect "/users/#{URI.encode(@user)}/watched"
    end

    get '/users/:user/watched' do
      @user = params[:user]
      @page = params[:page] || 1
      begin
        @watched = Github::Repos.new.watched :user => @user, :page => @page
      rescue Github::Error::NotFound
        @watched = []
        return haml :'user/not_found'
      end

      if request.xhr?
        haml :'user/watch_list', :layout => false
      else
        haml :'user/index'
      end
    end

    get '/readme/:name/:repository' do |name, repo|
      url = "https://github.com/#{name}/#{repo}"
      readme = Mechanize.new.get(url).at('#readme').to_s
      readme.empty? ? "README is not exist." : readme
    end

    get '/application.js' do
      coffee :"assets/coffee/application"
    end

    get '/application.css' do
      scss :"assets/scss/application"
    end
  end
end

