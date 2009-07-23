ActionController::Routing::Routes.draw do |map|
  map.resources :exams
  map.resources :user_exams
  map.resources :user_questions
  map.resources :users
  map.resources :questions, :member => { :change_type => [:get] }
  map.root :exams
end
