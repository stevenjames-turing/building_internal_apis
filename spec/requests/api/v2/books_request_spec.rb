require 'rails_helper'

describe 'Books API' do 
  it 'sends a list of books' do 
    author = create(:author)
    create_list(:book, 3, author_id: author.id)

    get "/api/v2/authors/#{author.id}/books"

    expect(response).to be_successful

    books = JSON.parse(response.body, symbolize_names: true)

    expect(books.count).to eq(3)

    books.each do |book| 
      expect(book).to have_key(:id)
      expect(book[:id]).to be_an Integer
      
      expect(book).to have_key(:title)
      expect(book[:title]).to be_a String
      
      expect(book).to have_key(:author_id)
      expect(book[:author_id]).to be_an Integer
      expect(book[:author_id]).to eq(author.id)
      
      expect(book).to have_key(:genre)
      expect(book[:genre]).to be_a String
      
      expect(book).to have_key(:summary)
      expect(book[:summary]).to be_a String
      
      expect(book).to have_key(:popularity)
      expect(book[:popularity]).to be_a String

      expect(book).to_not have_key(:number_sold)
    end
    

  end
end