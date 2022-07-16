# export data to firebase
require "google/cloud/firestore"



namespace :firebase do
  desc "Export all Trips to Firebase"
  task export: :environment do
    # The `project_id` parameter is optional and represents which project the
    # client will act on behalf of. If not supplied, the client falls back to the
    # default project inferred from the environment.
    puts "Created Cloud Firestore client with given project ID."
    firestore = Google::Cloud::Firestore.new project_id: ENV['FIRESTORE_PROJECT_ID']
    
    puts "Adding all documents that have stories to the trips collection"
    Trip.includes(:rides).references(:rides).where("rides.story != ''").order(id: 'desc').each do |trip|

      # add trip to firestore db if trip doesn't exist yet
      tripSnapshot = firestore.doc("trips/#{trip.id}").get
      if tripSnapshot.exists?
        putc '.'
      else
        t = firestore.collection('trips').document(trip.id).set(trip.to_firebase_document)
        puts "Added data #{trip.id} - from #{trip.from_city} to #{trip.to_city}"
      end

      # add user to firestore db if user doesn't exist yet
      userSnapshot = firestore.doc("users/#{trip.user.id}").get
      if not userSnapshot.exists?
        puts "User Document #{trip.user.username} does not exist"
        user = trip.user
        u = firestore.collection('users').document(user.id).set(user.to_firestore_document)
        puts "Added user ##{user.id} #{user.username}" if u
      end
    end
  end
end