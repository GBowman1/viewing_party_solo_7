class MoviesController < ApplicationController
    # def index
    #     @user = User.find(params[:user_id])
    #     if params[:movie].present?
    #         conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
    #             # faraday.headers['api_key'] = Rails.application.credentials.tmdb[:key]
    #             faraday.params[:api_key] =  Rails.application.credentials.tmdb[:key]
    #         end
    #         search = params[:movie].gsub(' ', '%20')
    #         response = conn.get("/3/search/movie?query=#{search}")

    #         json = JSON.parse(response.body, symbolize_names: true)
    #         @movies = json[:results]
    #     else
    #         conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
    #             # faraday.headers['api_key'] = Rails.application.credentials.tmdb[:key]
    #             faraday.params[:api_key] = Rails.application.credentials.tmdb[:key]
    #         end
    #         response = conn.get('3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc')
    #         # require 'pry';binding.pry

    #         json = JSON.parse(response.body, symbolize_names: true)
    #         @movies = json[:results]
    #     end
    #     # require 'pry';binding.pry
    # end



    def index
        @user = User.find(params[:user_id])
        @movies = MovieFacade.new.get_request(params)
    end

end