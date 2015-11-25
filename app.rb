# -*- coding: utf-8 -*-
require 'uri'
require 'github_api'
require 'mechanize'

require 'sinatra/base'
require 'coffee-script'
require 'haml'
require 'sass'

module OctoWatcher
  class App < Sinatra::Base
    set :haml, { :format => :html5 }

    get '/' do
      haml :index
    end

    get "/search" do
      @user = params[:user].gsub(/(^(\s|　)+)|((\s|　)+$)/, '')
      redirect "/users/#{URI.encode(@user)}/watched"
    end

    get '/users/:user/watched' do
      @user = params[:user]
      @page = params[:page].to_i || 1
      begin
        @watched = Github::Activity.new.starring.starred(:user => @user, :page => @page)
      rescue Github::Error::NotFound
        @watched = []
        return haml :'user/not_found'
      end

      if request.xhr?
        haml :'user/watched', :layout => false
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
