require 'faker'

FactoryGirl.define do
  factory :user do
    username  {Faker::Internet.user_name}
    email      {Faker::Internet.email}
    password              "password11"
    password_confirmation "password11"
    # avatar { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
    # trait :with_project do
    #   order {build(:order, total_price:200)}
    # end


  end
end