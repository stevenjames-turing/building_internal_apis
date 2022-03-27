require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do 
    it { should validate_presence_of :title }
    it { should validate_presence_of :genre }
    it { should validate_presence_of :summary }
    it { should validate_presence_of :number_sold }
    it { should validate_presence_of :popularity }
    it { should validate_numericality_of :number_sold }
  end
  describe 'relationships' do 
    it { should belong_to :author }
  end
end
