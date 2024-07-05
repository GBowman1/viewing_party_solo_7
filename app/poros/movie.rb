class Movie
    attr_reader :title, :vote_average, :id

    def initialize(data)
        @title = data[:title]
        @vote_average = data[:vote_average]
        @id = data[:id]
        @genres = genres_arr(data)
        @runtime = runtime_conversion(data[:runtime])
        @summary = data[:overview]
    end

    def genres_arr(data)
        genres = []
        data[:genres].each do |genre|
            genres << genre[:name]
        end
        genres
    end

    def runtime_conversion(runtime)
        hours = runtime / 60
        minutes = runtime % 60
        "#{hours} hr #{minutes} min"
    end
end