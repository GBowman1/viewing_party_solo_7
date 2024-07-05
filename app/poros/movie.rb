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
        @cast = data[:cast] || []
        @reviews = data[:reviews] || []
    end

    def genres_arr(genres_data)
        return [] if genres_data.nil?
        genres_data.map { |genre| genre[:name] }
    end

    def runtime_conversion(runtime)
        if runtime.nil?
            return "N/A"
        else
            hours = runtime / 60
            minutes = runtime % 60
            "#{hours} hr #{minutes} min"
        end
    end
end