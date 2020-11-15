# frozen_string_literal: true

require 'password_strength'
require 'serializers/password_strength_serializer'

class PasswordService < Sinatra::Base
  post '/strength' do
    password_strength = PasswordStrength.for(params['password']) do |ps|
      ps.apply_rule :sequence
      ps.apply_rule :case_words
      ps.apply_rule :black_list
    end

    PasswordStrengthSerializer.new(password_strength).to_json
  end
end
