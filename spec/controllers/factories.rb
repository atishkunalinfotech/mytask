FactoryGirl.define :user do |user|
  
  user.email                 "mhartl@example.com"
  user.password_salt              "password"
  user.password_hash "password"
end