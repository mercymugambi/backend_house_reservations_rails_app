# spec/factories/houses.rb
FactoryBot.define do
  factory :house do
    house_name { 'Sample House' }
    city { 'Sample City' }
    description { 'A cozy place to stay.' }
    bedrooms { 2 }
    bathrooms { 1 }
    rent { 1000 }
    security_deposit { 200 }
    contact_phone_number { '123-456-7890' }

    # Association with admin user
    association :admin_user, factory: :user
  end
end
