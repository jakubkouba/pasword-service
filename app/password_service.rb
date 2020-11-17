# frozen_string_literal: true

require 'password_strength'
require 'serializers/password_strength_serializer'

class PasswordService < Sinatra::Base
  post '/api/v1/password-strength' do
    payload = params
    payload = JSON.parse(request.body.read) unless params['password']

    password_strength = PasswordStrength.for(payload['password']) do |ps|
      ps.apply_rule length: { score: 10 }
      ps.apply_rule number: { score: 10 }
      ps.apply_rule symbol: { score: 25 }
      ps.apply_rule case_words: { score: 10 }
      ps.apply_rule sequence: { score: 5 }
      ps.apply_rule black_list: { score: 5 }

      ps.set_strength_threshold good: 32
      ps.set_strength_threshold strong: 60
    end

    [
      200,
      { 'Content-Type' => 'Application/json' },
      PasswordStrengthSerializer.new(password_strength).to_json
    ]
  end
end
