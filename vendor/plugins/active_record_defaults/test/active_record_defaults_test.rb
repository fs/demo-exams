require File.dirname(__FILE__) + '/abstract_unit'

class ActiveRecordDefaultsTest < Test::Unit::TestCase
  fixtures :people, :schools
  
  def test_defaults_for_new_record
    p = Person.new
    
    assert_equal 'Christchurch', p.city
    assert_equal 'New Zealand', p.country
    assert_equal 'Sean', p.first_name
    assert_equal 'Fitzpatrick', p.last_name
    assert_equal 2, p.lucky_number
    assert_equal 'Blue', p.favourite_colour
  end
  
  def test_default_ignored_if_key_present
    p = Person.new(:city => '', 'lucky_number' => nil)
    
    assert_equal '', p.city
    assert_equal nil, p.lucky_number
    
    assert_equal 'New Zealand', p.country
    assert_equal 'Sean', p.first_name
    assert_equal 'Fitzpatrick', p.last_name
    assert_equal 'Blue', p.favourite_colour
  end
  
  def test_defaults_should_be_duplicated
    one = Person.new
    two = Person.new
    
    assert_not_equal one.first_name.object_id, two.first_name.object_id
  end
  
  def test_existing_records_unchanged
    assert_nil Person.find(1).last_name
  end
  
  def test_default_relying_on_previous_default
    assert_equal "Red", Person.new(:last_name => 'Carter').favourite_colour
  end
  
  def test_defaults_on_create
    p = Person.create!
    
    assert_equal 'Christchurch', p.city
    assert_equal 'New Zealand', p.country
    assert_equal 'Sean', p.first_name
    assert_equal 'Fitzpatrick', p.last_name
    assert_equal 2, p.lucky_number
    assert_equal 'Blue', p.favourite_colour
  end
  
  def test_default_belongs_to_association
    assert_equal School.find(1), PersonWithDefaultSchool.new.school
  end
  
  def test_specific_belongs_to_foreign_key_value_overrides_association_default
    assert_nil PersonWithDefaultSchool.new(:school_id => nil).school
  end
  
  def test_default_belongs_to_association_by_id
    assert_equal School.find(1), PersonWithDefaultSchoolId.new.school
  end
  
  def test_specific_belong_to_association_overrides_default_foreign_key_value
    assert_nil PersonWithDefaultSchoolId.new(:school => nil).school
  end
  
  def test_initialize_model_without_any_defaults
    assert_nothing_raised { Group.new }
  end
end
