ActionController::Routing::Routes.draw do |map|
  map.resources :exams, :only => [:index, :show]
  map.resources :user_exams
  map.resources :user_questions

  map.root :exams
end
