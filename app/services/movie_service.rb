class MovieService
    def self.conn
        Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
        end
    end

    def self.top_rated_movies
        response = conn.get('3/discover/movie', {
            api_key: Rails.application.credentials.tmdb[:key],
            include_adult: false,
            include_video: false,
            language: 'en-US',
            page: 1,
            sort_by: 'popularity.desc'
        })

        JSON.parse(response.body, symbolize_names: true)
    end

    def self.search_for_movie(movie)
        response = conn.get('3/search/movie', {
            api_key: Rails.application.credentials.tmdb[:key],
            query: movie,
            language: 'en-US',
            page: 1
        })

        JSON.parse(response.body, symbolize_names: true)
    end

    def self.movie_details(id)
        response = conn.get("3/movie/#{id}", {
            api_key: Rails.application.credentials.tmdb[:key]
        })

        JSON.parse(response.body, symbolize_names: true)
    end
end
