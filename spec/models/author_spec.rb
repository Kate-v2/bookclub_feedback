require 'rails_helper'

describe Author, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end
end
