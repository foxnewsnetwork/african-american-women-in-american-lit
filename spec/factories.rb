Factory.define :user do |user|
  user.username "Test Testson"
  user.email "test@test.test"
  user.password "testing"
  user.password_confirmation "testing"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

