class MoviesController < ApplicationController
    def index
        @user = User.find(params[:user_id])
        @movies = MovieFacade.new.get_request(params)
    end

    def show
        @user = User.find(params[:user_id])
        @movie = MovieFacade.new.get_movie(params[:movie_id])
        @reviews = MovieFacade.new.get_reviews(params[:movie_id])
        @cast = MovieFacade.new.get_cast(params[:movie_id])
    end
end