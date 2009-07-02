class PersonWithDefaultSchool < Person
  default :school do
    School.find(1)
  end
end
