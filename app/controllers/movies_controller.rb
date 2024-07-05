class MoviesController < ApplicationController
    def index
        @user = User.find(params[:user_id])
        @movies = MovieFacade.new.get_request(params)
    end

end