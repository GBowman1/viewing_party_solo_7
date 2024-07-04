class MoviesController < ApplicationController
    def index
        @user = User.find(params[:user_id])
        if params[:movie].present?
            conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
                faraday.headers['X-API-Key'] = Rails.application.credentials.tmdb[:key]
            end
            response = conn.get("/3/search/movie?query=#{params[:movie]}")

            json = JSON.parse(response.body, symbolize_names: true)
            @movies = json[:results]
        else params[:top_rated].present?
            conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
                faraday.headers['X-API-Key'] = Rails.application.credentials.tmdb[:key]
            end
            response = conn.get('3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc')

            json = JSON.parse(response.body, symbolize_names: true)
            @movies = json[:results]
        end
    end
end