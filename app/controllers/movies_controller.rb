class MoviesController < ApplicationController
    def index
        @user = User.find(params[:user_id])
        @movies = MovieFacade.new.get_request(params)
    end

    def show
        @user = User.find(params[:user_id])
        @movie = MovieFacade.new.get_movie(params)
        @reviews = MovieFacade.new.get_reviews(params)
        @cast = MovieFacade.new.get_cast(params)
    end
end