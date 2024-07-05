class Movie
    attr_reader :title, 
                :vote_average, 
                :id,
                :genres,
                :runtime,
                :summary,
                :cast,
                :reviews

    def initialize(data)
        @title = data[:title]
        @vote_average = data[:vote_average]
        @id = data[:id]
        @genres = genres_arr(data[:genres])
        @runtime = runtime_conversion(data[:runtime])
        @summary = data[:overview]
        @cast = format_cast(data[:cast])
        @reviews = format_reviews(data[:reviews])
    end

    def genres_arr(genres_data)
        genres_data.map { |genre| genre[:name] }
    end

    def runtime_conversion(runtime)
        hours = runtime / 60
        minutes = runtime % 60
        "#{hours} hr #{minutes} min"
    end

    def format_cast(cast_data)
        cast_data.first(10).map { |cast| { character: cast[:character], name: cast[:name] } }
    end

    def format_reviews(reviews_data)
        reviews_data.map { |review| { author: review[:author], content: review[:content] } }
    end
end