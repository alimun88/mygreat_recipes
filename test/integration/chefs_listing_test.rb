require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chef_name: "mashrur", email: "mashrur@example.com",
                    password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chef_name: "john", email: "john@example.com",
                    password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chef_name: "john1", email: "john1@example.com",
                        password: "password", password_confirmation: "password", admin: true) 
  end
  
  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chef_name.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chef_name.capitalize
  end
  
  test "should delete chef" do
    sign_in_as(@admin_user, "password")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
   
   test "associated recipes should be destroyed" do
    @chef.save
    @chef.recipes.create!(name: "testing delete", ingedients: "some ingedients", description: "testing delete function")
    assert_difference 'Recipe.count', -1 do
      @chef.destroy
    end
  end
  
  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chef_name: "mashrur3", 
                                  email: "mashrur3@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "mashrur3", @chef.chef_name
    assert_match "mashrur3@example.com", @chef.email
  end
  
  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: { chef: { chef_name: updated_name, 
                                  email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "mashrur", @chef.chef_name
    assert_match "mashrur@example.com", @chef.email
  end
  
end
