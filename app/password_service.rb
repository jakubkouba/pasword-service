# frozen_string_literal: true

require 'password_strength'
require 'serializers/password_strength_serializer'

class PasswordService < Sinatra::Base
  post '/api/v1/password_strength' do
    password_strength = PasswordStrength.for(params['password']) do |ps|
      ps.apply_rule :length
      ps.apply_rule :number
      ps.apply_rule :symbol
      ps.apply_rule :case_words
      ps.apply_rule :sequence
      ps.apply_rule :black_list
    end

    [
      200,
      { 'Content-Type' => 'Application/json' },
      PasswordStrengthSerializer.new(password_strength).to_json
    ]
  end
end
