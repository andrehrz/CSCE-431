FactoryBot.define do
    factory :account do
        email {FFaker::Internet.email}
        password {Devise.friendly_token.first(8)}
    end
end