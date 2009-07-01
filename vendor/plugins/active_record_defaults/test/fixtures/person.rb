class Person < ActiveRecord::Base
  belongs_to :school
  
  # Include an aggregate reflection to check compatibility
  composed_of :address, :mapping => [%w(address_suburb suburb), %{address_city city}]
  
  defaults :city => 'Christchurch', :country => Proc.new { 'New Zealand' }
  
  default :first_name => 'Sean'
  
  default :last_name do
    'Fitzpatrick'
  end
  
  defaults :lucky_number => proc { 2 }, :favourite_colour => :default_favourite_colour
  
  def default_favourite_colour
    last_name == 'Fitzpatrick' ? "Blue" : "Red"
  end
end
