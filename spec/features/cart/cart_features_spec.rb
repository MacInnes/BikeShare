require 'rails_helper'

describe 'A user visits bike shop' do
  describe 'it sees a list of items' do
    it 'can add individual accessories to a shopping cart' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'http://placekitten/200/200')
      part_2 = Accessory.create(title: 'thing2', description: 'kjhgt6s', price: 6, status: 0, image: 'http://placekitten/200/200')

      visit '/bike-shop'

      within "#accessory-#{part_1.id}" do
        click_on 'Add to Cart'
      end

      expect(page).to have_content("You have added #{part_1.title} to your cart.")

      visit root_path

      expect(page).to have_content('Cart Count: 1')
    end
    it 'can change the quantity of an item' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'http://placekitten/200/200')

      visit '/bike-shop'

      within "#accessory-#{part_1.id}" do
        click_on 'Add to Cart'
      end

      visit cart_path

      fill_in :new_quantity, with: 5
      click_on "Update Quantity"

      expect(page).to have_content("Quantity: 5")

      fill_in :new_quantity, with: 2
      click_on "Update Quantity"

      expect(page).to have_content("Quantity: 2")
    end
    it 'cannot change the quantity to 0 or a negative value' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'http://placekitten/200/200')

      visit '/bike-shop'

      within "#accessory-#{part_1.id}" do
        click_on 'Add to Cart'
      end

      visit cart_path

      fill_in :new_quantity, with: -5
      click_on "Update Quantity"

      expect(page).to_not have_content("Quantity: -5")
      expect(page).to have_content("Quantity: 1")
    end
    it 'can use buttons to increase or decrease the quantity by 1' do
      part_1 = Accessory.create(title: 'thing1', description: 'kjhs', price: 4, status: 0, image: 'http://placekitten/200/200')

      visit '/bike-shop'

      within "#accessory-#{part_1.id}" do
        click_on 'Add to Cart'
      end

      visit cart_path

      click_on("+")
      expect(page).to have_content("Quantity: 2")

      click_on("-")
      expect(page).to have_content("Quantity: 1")
    end
  end
end
