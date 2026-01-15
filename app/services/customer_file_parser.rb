# frozen_string_literal: true

require "json"

class CustomerFileParser
  def initialize(file)
    @file = file
  end

  def call
    customers = []

    File.foreach(@file.path) do |line|
      customers << JSON.parse(line, symbolize_names: true)
    rescue JSON::ParserError
      return [ nil, "Invalid JSON format detected in input file" ]
    end

    [ customers, nil ]
  rescue Errno::ENOENT
    [ nil, "File not found" ]
  end
end
