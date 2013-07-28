desc 'Import Photos'
task :import_photos do
  puts 'importing photos...'
  [
    "09082011327.jpg",
    "DSC04632.JPG",
    "IMG_1484.JPG",
    "IMG_1881.JPG",
    "IMG_5733.JPG",
    "IMG_5737.JPG"
  ].each do |photo_file_name|
    ride = Ride.where(photo_file_name: photo_file_name).first
    ride.photo = File.open("#{Rails.root}/hitchlog_backup/#{photo_file_name}")
    puts "Saving Photo #{photo_file_name} for Ride #{ride.number} of #{ride.to_param}"
    ride.save!
  end
end
