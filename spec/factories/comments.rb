FactoryGirl.define do
  factory :comment do
    task
    text "MyString"
    author "lolo"
    attach "MyString"
  end
end
