FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@test.com' }
    password              { 'abc123' }
    password_confirmation { 'abc123' }
    first_name            { '山田' }
    last_name             { '太郎' }
    first_name_kana       { 'ヤマダ' }
    last_name_kana        { 'タロウ' }
    birth_date            { '1990-01-01' }
  end
end
