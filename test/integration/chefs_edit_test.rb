require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
   @chef = Chef.create!(chef_name: "mohammad", 
                      email: "mohammad@example.com",
                          password: "password", 
                          password_confirmation: "password")
  end
  
  test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chef_name: " ", 
                              email: "mohammad@example.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
    test "accept valid signup" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chef_name: "mohammad1", 
                                email: "mohammad1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "mohammad1", @chef.chef_name
    assert_match "mohammad1@example.com", @chef.email
  end
end
