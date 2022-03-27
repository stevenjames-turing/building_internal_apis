require 'rails_helper'

describe 'Authors API' do 
  it 'sends a list of authors' do 
    create_list(:author, 3)

    get "/api/v1/authors"

    expect(response).to be_successful

    authors = JSON.parse(response.body, symbolize_names: true)

    expect(authors.count).to eq(3)

    authors.each do |author|  
      expect(author).to have_key(:id)
      expect(author[:id]).to be_an Integer

      expect(author).to have_key(:first_name)
      expect(author[:first_name]).to be_a String 
      
      expect(author).to have_key(:last_name)
      expect(author[:last_name]).to be_a String 
    end 
  end

  it 'can get one author by its id' do 
    id = create(:author).id 

    get "/api/v1/authors/#{id}"

    author = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(author).to have_key(:id)
    expect(author[:id]).to eq(id)

    expect(author).to have_key(:first_name)
    expect(author[:first_name]).to be_a String 
    
    expect(author).to have_key(:last_name)
    expect(author[:last_name]).to be_a String 
  end

  it 'can create a new author' do 
    author_params = ({
                      first_name: 'Bruce',
                      last_name: 'Banner'
                    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/authors", headers: headers, params: JSON.generate(author: author_params)
    created_author = Author.last 

    expect(response).to be_successful
    expect(created_author.first_name).to eq(author_params[:first_name])
    expect(created_author.last_name).to eq(author_params[:last_name])
  end

  it 'can update an existing author' do 
    id = create(:author).id 
    previous_name = Author.last.last_name
    author_params = { last_name: "Banner" }
    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/authors/#{id}", headers: headers, params: JSON.generate(author: author_params)
    author = Author.find_by(id: id)

    expect(response).to be_successful
    expect(author.last_name).to_not eq(previous_name)
    expect(author.last_name).to eq("Banner")
  end

  it 'can destroy an author' do 
    author = create(:author)

    expect(Author.count).to eq(1)

    delete "/api/v1/authors/#{author.id}"

    expect(response).to be_successful
    expect(Author.count).to eq(0)
    expect(Author.find(author.id)).to raise_error(ActiveRecord::RecordNotFound)
  end
end