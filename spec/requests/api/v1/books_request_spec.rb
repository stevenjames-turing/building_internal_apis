require 'rails_helper'

describe 'Books API' do 
  it 'sends a list of books' do 
    author = create(:author)
    create_list(:book, 3, author_id: author.id)

    get "/api/v1/authors/#{author.id}/books"

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
      
      expect(book).to have_key(:number_sold)
      expect(book[:number_sold]).to be_an Integer
    end
  end
  
  it 'can get one book by its id' do 
    author = create(:author)
    id = create(:book, author_id: author.id).id
    
    get "/api/v1/authors/#{author.id}/books/#{id}"
    
    book = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    
    expect(book).to have_key(:id)
    expect(book[:id]).to eq(id)
    
    expect(book).to have_key(:title)
    expect(book[:title]).to be_a String
    
    expect(book).to have_key(:author_id)
    expect(book[:author_id]).to be_an Integer
    expect(book[:author_id]).to eq(author.id)
    
    expect(book).to have_key(:genre)
    expect(book[:genre]).to be_a String
    
    expect(book).to have_key(:summary)
    expect(book[:summary]).to be_a String
    
    expect(book).to have_key(:number_sold)
    expect(book[:number_sold]).to be_an Integer
  end
  
  it 'can create a new book' do 
    author = create(:author)
    book_params = ({
                    title: 'Murder on the Orient Express', 
                    author_id: author.id, 
                    genre: 'mystery', 
                    summary: 'Filled with suspense.', 
                    number_sold: 432
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    # We include this header to make sure that these params are passed as JSON rather that as plain text

    post "/api/v1/authors/#{author.id}/books", headers: headers, params: JSON.generate(book: book_params)
    created_book = Book.last

    expect(response).to be_successful
    expect(created_book.title).to eq(book_params[:title])
    expect(created_book.author_id).to eq(book_params[:author_id])
    expect(created_book.summary).to eq(book_params[:summary])
    expect(created_book.genre).to eq(book_params[:genre])
    expect(created_book.number_sold).to eq(book_params[:number_sold])
  end

  it 'can update an existing book' do 
    author = create(:author)
    id = create(:book, author_id: author.id).id
    previous_name = Book.last.title 
    book_params = { title: "Charlotte's Web" }
    headers = {"CONTENT_TYPE" => "application/json"}

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    patch "/api/v1/authors/#{author.id}/books/#{id}", headers: headers, params: JSON.generate({book: book_params})
    book = Book.find_by(id: id)

    expect(response).to be_successful
    expect(book.title).to_not eq(previous_name)
    expect(book.title).to eq("Charlotte's Web")
  end

  it 'can destroy a book' do 
    author = create(:author)
    book = create(:book, author_id: author.id)

    expect(Book.count).to eq(1) 

    delete "/api/v1/authors/#{author.id}/books/#{book.id}"

    expect(response).to be_successful
    expect(Book.count).to eq(0)
    expect{Book.find(book.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end