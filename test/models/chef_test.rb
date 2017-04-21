require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chef_name: "Raj Kumar", email: "raj@example.com")
  end
  
  test "chef should be preent" do
    assert @chef.valid?
  end
  
   test "chef_name should be valid" do
    @chef.chef_name = " "
    assert_not @chef.valid?
  end
  
  test "length should be less than 30 character" do
    @chef.chef_name = "a" * 31
    assert_not @chef.valid?
  end
  
  test "email should be valid" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email length should be less than 255 character" do
    @chef.email = "a" * 256 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email should accept correct format" do
    valid_emails = %w[user@example.com MASHRUR@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "should reject invalid addresses" do
    invalid_emails = %w[mashrur@example mashrur@example,com mashrur.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
  test "email should be lowercase before hitting db" do
    mixed_email = "JohnDoE@Example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
end