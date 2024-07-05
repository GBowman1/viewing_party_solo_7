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

    # def get_movie(params)
    #     json = MovieService.movie_details(params[:id])
    #     Movie.new(json)
    # end

    # def get_reviews(movie_id)
    #     json = MovieService.movie_reviews(movie_id)
    #     json[:results].map do |review_data|
    #         Review.new(review_data)
    #     end
    # end

    # def get_cast(movie_id)
    #     json = MovieService.movie_cast(movie)
    #     json[:cast].map do |cast_data|
    #         Cast.new(cast_data)
    #     end.first(10)
    # end
    def get_movie_details(movie_id)
        details = MovieService.movie_details(movie_id)
        cast = get_cast(movie_id)
        reviews = get_reviews(movie_id)
        details[:cast] = cast
        details[:reviews] = reviews
        Movie.new(details)
    end

    def get_cast(movie_id)
        json = MovieService.movie_cast(movie_id)
        json[:cast].first(10).map do |cast_data|
            { character: cast_data[:character], name: cast_data[:name] }
        end
    end

    def get_reviews(movie_id)
        json = MovieService.movie_reviews(movie_id)
        json[:results].map do |review_data|
            { author: review_data[:author], content: review_data[:content] }
        end
    end
end
