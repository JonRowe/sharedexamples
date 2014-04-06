require 'dotenv'
require 'json'
Dotenv.load

desc "Deploy"
task :deploy do
  `middleman build`
  JSON.parse(ENV['S3_BUCKETS']).each do |bucket,region|
    `S3_BUCKET=#{bucket} S3_REGION=#{region} middleman sync`
  end
end
