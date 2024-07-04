class MoviesController < ApplicationController
    def index
        @user = User.find(params[:user_id])
        if params[:search] == 'top_rated'
            conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
                faraday.headers['X-API-Key'] = Rails.application.credentials.tmdb[:key]
            end
            response = conn.get('3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc')
            # require 'pry';binding.pry

            json = JSON.parse(response.body, symbolize_names: true)
            @movies = json[:results]
        elsif params[:search] == 'query'
            conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
                faraday.headers['X-API-Key'] = Rails.application.credentials.tmdb[:key]
            end
            search = params[:movie].gsub(' ', '%20')
            response = conn.get("/3/search/movie?query=#{search}")

            json = JSON.parse(response.body, symbolize_names: true)
            @movies = json[:results]
        else 
            @movies = []
        end
        # require 'pry';binding.pry
    end

end