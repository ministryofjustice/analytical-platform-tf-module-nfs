# frozen_string_literal: true

require 'awspec'
require 'fileutils'
require 'colorize'
require 'json'
require_relative 'tfjson.json'

@plan_path = './fixtures/tfjson.json'
raise "#{@plan_path} not found".red unless Dir.exist?(@plan_path)

def resource(aws_resource)
  File.open(@plan_path) do |plan_file|
    parsed_json = JSON.parse(plan_file.read)
    return parsed_json['planned_values']['root_module']['child_modules'][0]\
    ['resources'].select { |resource| resource['type'] == aws_resource }[0]
  end
end

creds = Aws::AssumeRoleCredentials.new(
  client: Aws::STS::Client.new,
  role_arn: 'arn:aws:iam::312423030077:role/read-only-dev',
  role_session_name: 'DEV-Session'
)
Aws.config.update(credentials: creds)
