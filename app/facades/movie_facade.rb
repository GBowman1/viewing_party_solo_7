class MovieFacade

    def get_request(params)
        if params[:movie].present?
            search_for_movie(params[:movie])
        else
            get_top_rated_movies
        end
    end

    def get_top_rated_movies
        json = MovieService.top_rated_movies
        json[:results].map do |movie_data|
            Movie.new(movie_data)
        end
    end

    def search_for_movie(movie)
        json = MovieService.search_for_movie(movie)
        json[:results].map do |movie_data|
            Movie.new(movie_data)
        end
    end

    def get_movie(params)
        json = MovieService.movie_details(params[:id])
        Movie.new(json)
    end

    def get_reviews(params)
        json = MovieService.movie_reviews(params[:id])
        json[:results].map do |review_data|
            Review.new(review_data)
        end
    end

    def get_cast(params)
        json = MovieService.movie_cast(params[:id])
        json[:cast].map do |cast_data|
            Cast.new(cast_data)
        end
    end
end
