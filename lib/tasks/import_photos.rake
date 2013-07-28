desc 'Import Photos'
task import_photos: :environment do
  puts 'importing photos...'
  [ 7609, 7617, 7618, 7619 ].each do |ride_id|
    ride = Ride.find( ride_id )
    ride.photo = File.open("#{Rails.root}/hitchlog_backup/#{ride_id}.jpg")
    puts "Saving Photo #{photo_file_name} for Ride #{ride.number} of #{ride.to_param}"
    ride.save!
  end
end
