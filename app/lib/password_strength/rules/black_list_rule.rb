# frozen_string_literal: true

require 'password_strength/rules/base'

module PasswordStrength
  module Rules
    class BlackListRule < Base

      attr_reader :black_list_file

      BLACK_LIST_FILE_DIR = File.expand_path('../conf', __FILE__ )

      def initialize(password:, option: nil, score: 15, black_list_file: 'password_black_list.txt')
        @black_list_file = "#{BLACK_LIST_FILE_DIR}/#{black_list_file}"
        super(password: password, option: nil , score: score)
      end

      def passed?
        true
      end
    end
  end
end
