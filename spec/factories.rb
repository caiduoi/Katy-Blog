FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :entry do
    title "Entry title"
    body "Entry body"
    user
  end
  
  factory :comment do
    content "Comment"
    user
    entry
  end
  
end
