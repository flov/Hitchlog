class MigrateYoutubeDataToRidesYoutubeAttribute < ActiveRecord::Migration
  def up
    [
      [25110, 'Spx1Wqe32Q4'],
      [26385, 'e1YRdKFsT-c'],
      [59, 'ksMkENKMlyk']
    ].each do |ride|
      begin
        if Ride.find(ride[0]).update_attributes(youtube: ride[1])
          puts "Updated Ride #{ride[0]} with youtube id: #{ride[1]}"
        end
      rescue
        puts "Ride #{ride[0]} not found"
      end
    end
  end
end
