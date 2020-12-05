require 'rails_helper'

RSpec.describe User, type: :model do
  describe "name" do
    context "blankの時に" do
      let(:user) do
        build(:user, name: "")
      end
      it "invalidになる" do
        expect(user).not_to be_valid
      end
    end
    context 'maxlength' do
      context '30文字' do
        let(:user) do
          build(:user, name: "あ" * 30)
        end
        it 'to valid' do
          expect(user).to be_valid
        end
      end
      context '31文字' do
        let(:user) do
          build(:user, name: "あ" * 31)
        end
        it 'to invalid' do
          expect(user).not_to be_valid
        end
      end
    end
  end

  describe 'email' do
    context 'when blank' do
      let(:user) do
        build(:user, email: "")
      end
      it 'to invalid' do
        expect(user).not_to be_valid
      end
    end
    context 'maxlength' do
      context 'length 100' do
        let(:user) do
          build(:user, email: "@example.com".rjust(100, "a"))
        end
        it 'to valid' do
          expect(user).to be_valid
        end
      end
      context 'length 101' do
        let(:user) do
          build(:user, email: "@example.com".rjust(101, "a"))
        end
        it 'to invalid' do
          expect(user).not_to be_valid
        end
      end
    end
    context "email format" do
      context 'good case' do
        let(:user) do
          build(:user, email: 'test@example.com')
        end
        it 'be valid' do
          expect(user).to be_valid 
        end
      end
      context 'bad case' do
        let(:user) do
          build(:user, email: 'test@example')
        end
        it 'be invalid' do
          expect(user).not_to be_valid 
        end
      end
    end
  end
end

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
