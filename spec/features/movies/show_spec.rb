require 'rails_helper'

RSpec.describe 'Movies Show Page', type: :feature do
    before(:each) do
        @user = User.create!(name: 'Mike Tyson', email: 'miketyson@aol.com')
        @top_rated_response = File.read('spec/fixtures/top_rated_fixture.json')
        @search_response = File.read('spec/fixtures/search_fixture.json')
        @movie_details_response = File.read('spec/fixtures/show_fixture.json')
        @movie_reviews_response = File.read('spec/fixtures/reviews_fixture.json')
        @movie_cast_response = File.read('spec/fixtures/cast_fixture.json')

        stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc").
        to_return(status: 200, body: @top_rated_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=The%20Godfather&language=en-US&page=1").
        to_return(status: 200, body: @search_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/movie/786892?api_key=#{Rails.application.credentials.tmdb[:key]}").
        to_return(status: 200, body: @movie_details_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/movie/786892/reviews?api_key=#{Rails.application.credentials.tmdb[:key]}&page=1").
        to_return(status: 200, body: @movie_reviews_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/movie/786892/credits?api_key=#{Rails.application.credentials.tmdb[:key]}").
        to_return(status: 200, body: @movie_cast_response, headers: {})
    end

    it 'shows movie details' do
        visit user_movies_path(@user)

        within '#movie_1' do
        expect(page).to have_link("Furiosa: A Mad Max Saga")
        click_link("Furiosa: A Mad Max Saga")
        end
        expect(current_path).to eq(user_movie_path(@user, 786892))

        expect(page).to have_content("Furiosa: A Mad Max Saga")
        expect(page).to have_content("Vote Average: 7.696")
        expect(page).to have_content("Runtime: 2 hr 29 min")
        expect(page).to have_content("Overview: As the world fell, young Furiosa is snatched from the Green Place of Many Mothers and falls into the hands of a great Biker Horde led by the Warlord Dementus. Sweeping through the Wasteland they come across the Citadel presided over by The Immortan Joe. While the two Tyrants war for dominance, Furiosa must survive many trials as she puts together the means to find her way home.")
        expect(page).to have_content("Genres: Action, Adventure, Science Fiction")
        expect(page).to have_content("Total Reviews: 7")

        within '#cast' do
        expect(page).to have_content("Anya Taylor-Joy")
        expect(page).to have_content("Chris Hemsworth")
        expect(page).to have_content("Tom Burke")
        expect(page).to_not have_content("Elsa Pataky")
        end

        within '#review_list' do
            within '#review_1' do
                expect(page).to have_content("Author: Ritesh Mohapatra")
                expect(page).to have_content("Review: Furiosa (⭐⭐⭐⭐) is a relentless, adrenaline-pumping actioner from #GeorgeMiller, set in a post-apocalyptic wasteland. The film's action sequences are brutal, exciting, and innovative, featuring engaging set pieces and characters. Despite a somewhat thin premise, the action remains a standout. #ChrisHemsworth delivers a compelling performance, his intimidating presence suggesting potential for a spin-off origin film for his character. #AnyaTaylorJoy is commendable, bringing sufficient depth to her role. However, the subplot exploring Furiosa's origins feels weak and underdeveloped. Overall, Furiosa serves as a worthy prequel with unparalleled action choreography, although the climax may feel off and stretched, potentially disappointing fans expecting a stronger ending.\\r\\n\\r\\nWatch or Not?\\r\\nIf you liked Mad Max Fury Road, then go for this, action lovers go for this. Keep expectations at bay.")
            end
        end
    end

    it 'has a button to return to the discover page' do
        visit user_movie_path(@user, 786892)
        click_button 'Back to Discover'

        expect(current_path).to eq(user_discover_index_path(@user))
    end

    it 'has a button to create a viewing party' do
        visit user_movie_path(@user, 786892)
        click_button 'Create a Viewing Party'

        expect(current_path).to eq(new_user_movie_viewing_party_path(@user, 786892))
    end
end