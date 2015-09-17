namespace :mailchimp do
  desc "Subscribe all users to Mailchimp (set MAILCHIMP_API_KEY before)"
  task subscribe: :environment do
    require 'gibbon'

    gibbon = Gibbon::Request.new
    gibbon.timeout = 30
    list_id = gibbon.lists.retrieve["lists"].first["id"]

    User.find_each do |user|
      begin 
        gibbon.lists(list_id).members.create(body: {email_address: user.email, status: "subscribed"})
        puts "Subscribed #{user.email}"
      rescue Gibbon::MailChimpError => mail_error
        puts "#{mail_error.title}: #{mail_error.detail}"
      end
    end
  end
end
