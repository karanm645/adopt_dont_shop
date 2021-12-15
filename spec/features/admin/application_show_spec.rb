require 'rails_helper' 

RSpec.describe "Admin Application Show Page" do
  before :each do 
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    
    @pet1 = Pet.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: @shelter_1.id)
    @pet2 = Pet.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_1.id)
    @pet3 = Pet.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: @shelter_3.id)
   
    @application_1 = App.create!(name: "Rick James", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 0)
    @application_2 = App.create!(name: "Charlie Murphy", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 1)
    @application_3 = App.create!(name: "Prince", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 1)

    @app_pet1 = AppPet.create!(app_id: @application_1.id, pet_id: @pet1.id)
    @app_pet2 = AppPet.create!(app_id: @application_1.id, pet_id: @pet2.id)
    @app_pet3 = AppPet.create!(app_id: @application_2.id, pet_id: @pet3.id)

    visit "/admin/applications/#{@application_1.id}"

  end 
  describe 'when i visit the admin show page' do 
    xit 'has every pet that the application is for' do 
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
    end
    
    it 'shows see a button to approve the application for that specific pet' do 
      click_button "Approve"
      
      expect(page).to_not have_button("Approve")
    end 
  end 
end 

# Approving a Pet for Adoption

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved