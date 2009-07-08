ActionController::Routing::Routes.draw do |map|
  map.resources :exams
  map.resources :user_exams
  map.resources :user_questions
  map.resources :users
  map.resources :exam_questions
  map.root :exams
end
