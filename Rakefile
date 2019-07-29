# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'fileutils'
require 'colorize'
task default: %w[prerequisites:is_unzip_installed prerequisites:is_terraform_installed
                 :unit]
task spec: :unit

PROJECT_DIR = '.'

namespace :prerequisites do
  TERRAFORM_VERSION = '0.12.1'

  task :is_unzip_installed do
    `which unzip`
    unless $CHILD_STATUS == 0
      puts "Installing unzip....\n".green
      `sudo apt-get update && sudo apt-get install unzip -y`
    end
  end

  task :is_terraform_installed do
    desired_terraform_version = `terraform version | grep -- v#{TERRAFORM_VERSION}`
    terraform = `which terraform`
    if terraform && desired_terraform_version

      puts 'Good to go...'.green

    else

      puts "Terraform is either not installed or is not at the desired version\n\n".red

      puts "Installing Terraform v#{TERRAFORM_VERSION} now....\n".green

      fetch_terraform = "curl -O https://releases.hashicorp.com/terraform/#{TERRAFORM_VERSION}/terraform_#{TERRAFORM_VERSION}_linux_amd64.zip"

      unzip_terraform = "unzip terraform_#{TERRAFORM_VERSION}_linux_amd64.zip"

      system(fetch_terraform)

      system(unzip_terraform)

    end
  end
end

RSpec::Core::RakeTask.new(:unit) do |t|
  t.pattern = PROJECT_DIR
end
