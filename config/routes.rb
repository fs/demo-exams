ActionController::Routing::Routes.draw do |map|
  map.resources :exams do |exams|
    exams.resources :questions, :member => { :change_type => [:get] }
  end
  map.resources :user_exams
  map.resources :user_questions
  map.resources :users
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.login 'login', :controller => 'clearance/sessions', :action => 'new'
  map.logout 'logout', :controller => 'clearance/sessions', :action => 'destroy'
  map.root :exams
end
