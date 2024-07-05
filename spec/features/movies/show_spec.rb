require 'rails_helper'

RSpec.describe 'Movies Index Page', type: :feature do
    before(:each) do
        @user = User.create!(name: 'Mike Tyson', email: 'miketyson@aol.com')
        @top_rated_response = File.read('spec/fixtures/top_rated_fixture.json')
        @search_response = File.read('spec/fixtures/search_fixture.json')

        stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc").
        to_return(status: 200, body: @top_rated_response, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=The%20Godfather&language=en-US&page=1").
        to_return(status: 200, body: @search_response, headers: {})
    end

    it 'shows movie details' do
        visit user_movies_path(@user)

        within '#movie_1' do
            expect(page).to have_link("Furiosa: A Mad Max Saga")
            click_link("Furiosa: A Mad Max Saga")
        end
        expect(current_path).to eq(user_movie_path(@user, movie_id: 786892))

        expect(page).to have_content("Furiosa: A Mad Max Saga")
        expect(page).to have_content("Vote Average: 7.715")
        expect(page).to have_content("Runtime: ")
        expect(page).to have_content("Overview: As the world fell, young Furiosa is snatched from the Green Place of Many Mothers and falls into the hands of a great Biker Horde led by the Warlord Dementus. Sweeping through the Wasteland they come across the Citadel presided over by The Immortan Joe. While the two Tyrants war for dominance, Furiosa must survive many trials as she puts together the means to find her way home.")
        expect(page).to have_content("Genres: Action, Adventure, Science Fiction")
        expect(page).to have_content("Cast: ")
        expect(page).to have_content("Total Reviews: ")

        within '#review_list' do
            within '#review_1' do
                expect(page).to have_content("Author: ")
                expect(page).to have_content("Review: ")
            end
        end
    end

    it 'has a button to return to the discover page' do
        visit user_movie_path(@user, movie_id: 786892)
        click_button 'Back to Discover'

        expect(current_path).to eq(user_discover_path(@user))
    end

    it 'has a button to create a viewing party' do
        visit user_movie_path(@user, movie_id: 786892)
        click_button 'Create Viewing Party'

        expect(current_path).to eq(new_user_party_path(@user))
    end
end