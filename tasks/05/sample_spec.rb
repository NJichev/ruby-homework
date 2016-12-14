require 'rspec'
require_relative 'solution'

RSpec.describe DataModel do
  let(:user_model) do
    Class.new(DataModel) do
      attributes :first_name, :last_name
      data_store HashStore.new
    end
  end


  describe '.attributes' do
    it 'returns said attributes' do
      expect(user_model.attributes).to match_array [:first_name, :last_name]
    end
  end

  it 'creates attribute accessors' do
    record = user_model.new
    record.first_name = 'Pesho'
    record.last_name  = 'Petrov'

    expect(record).to have_attributes first_name: 'Pesho', last_name: 'Petrov'
  end

  describe '#new' do
    it 'accepts hash for parameters' do
      record = user_model.new(first_name: 'Pesho', last_name: 'Petrov')
      expect(record).to have_attributes first_name: 'Pesho', last_name: 'Petrov'
    end

    it 'ignores unset attributes' do
      record = user_model.new(first_name: 'Pesho', last_name: 'Petrov',
                              email: 'petrov@abv.bg', password: '1234')
      expect(record).to have_attributes first_name: 'Pesho', last_name: 'Petrov'
    end

    it "sets default value to nil if not given" do
      record = user_model.new
      expect(record).to have_attributes first_name: nil, last_name: nil
    end
  end

  describe '.where' do
    it 'finds with one attribute' do
      user_model.new(first_name: 'Pesho', last_name: 'Petrov').save
      user_model.new(first_name: 'Pesho', last_name: 'Petrov').save
      user_model.new(first_name: 'Pesho', last_name: 'Petrov').save

      expect(user_model.where(first_name: 'Pesho', last_name: 'Petrov').count).to eq 3
    end
  end

  describe '#id' do
    it 'returns nil if unpersisted object' do
      expect(user_model.new.id).to be nil
    end

    it 'returns id in store if saved' do
      expect(user_model.new.save.id).to eq 1
      expect(user_model.new.save.id).to eq 2
      expect(user_model.new.save.id).to eq 3
    end
  end


  describe '#delete' do
    it "raises an exception if the record isn't persisted to the data store" do

    end
  end
end

RSpec.shared_examples_for 'a data store' do
  subject(:store) { described_class.new }

  describe '#create' do
    it 'saves a new record' do
      user = {id: 2, name: 'Pesho'}
      store.create(user)

      expect(store.find(id: 2)).to match_array [user]
    end
  end

  describe '#find' do
    it 'finds records' do
      user = {id: 1, name: 'Pesho'}
      admin = {id: 2, name: 'Gosho', admin: true}
      client = {id: 3, name: 'Pesho'}

      store.create(user)
      store.create(admin)
      store.create(client)

      expect(store.find(name: 'Pesho')).to match_array [user, client]
    end

    it 'returns an empty array if none are found' do
      expect(store.find(name: 'Pesho')).to match_array []
    end
  end

  describe '#update' do
    it 'updates a record' do
      user = {id: 2, name: 'Gosho', email: 'gosho@abv.bg'}
      store.create(user)
      new_attributes = {name: 'Pesho', email: 'pesho@abv.bg'}

      store.update(2, new_attributes)
      expect(store.find(id: 2)).to match_array [new_attributes.merge({id: 2})]
    end
  end

  describe '#delete' do
    it 'deletes a record' do
      user = {id: 1, name: 'Pesho'}
      admin = {id: 2, name: 'Gosho', admin: true}
      client = {id: 3, name: 'Pesho'}

      store.create(user)
      store.create(admin)
      store.create(client)

      store.delete(name: 'Pesho')
      expect(store.find(name: 'Gosho')).to match_array [admin]
    end
  end
end

describe HashStore do
  it_behaves_like 'a data store'
end

describe ArrayStore do
  it_behaves_like 'a data store'
end
