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
end