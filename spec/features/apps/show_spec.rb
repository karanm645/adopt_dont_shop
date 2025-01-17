require 'rails_helper'
RSpec.describe 'the application show' do 
  before :each do 
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create!(adoptable: true, age: 5, breed: "Pug", name: "James")
    @pet_2 = @shelter.pets.create!(adoptable: true, age: 5, breed: "Pug", name: "Clawdia")
    @application_1 = App.create!(name: "Rick James", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 0)
    visit "/apps/#{@application_1.id}"
  end 
  it "shows the appliation and all it's attributes" do 
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@pet_1.name)
  end 

  it 'can add pets to an application' do #combine this test and the next into one
    expect(page).to have_content("Add a Pet to this Application")

    fill_in("Add a Pet to this Application", with: "James")

    click_button("Search")
    expect(current_path).to eq("/apps/#{@application_1.id}")
    expect(page).to have_content("James")
  end 

  it 'can search for pets for an application' do 
    fill_in("Add a Pet to this Application", with: "James")
    click_button("Search")

    within '#james' do 
      click_button "Adopt this Pet"
      expect(current_path).to eq("/apps/#{@application_1.id}")
    end 

    expect(current_path).to eq("/apps/#{@application_1.id}")
    expect(page).to have_content("James")

    fill_in :description, with: "Because I'm a good human"
    
    within "#Submit" do 
      click_button "Submit"
    end 

    expect(current_path).to eq("/apps/#{@application_1.id}")

    expect(page).to have_content("Pending")
    expect(page).to have_content("James")
    expect(page).to have_content("Rick")
    expect(page).to_not have_content("Adopt this Pet")
  end 

  describe 'if i have not added pets to application' do 
    it 'does not have a section to submit my app' do 
      expect(page).to_not have_content("Submit")
    end 
  end 

  it ' has a partial match for pet names' do 
    fill_in("Add a Pet to this Application", with: "Cla")
    click_button "Search"
    expect(page).to have_content("Clawdia")
  end 
end