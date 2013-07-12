describe "google_timeago", ->
  it "should return correct format", ->
    expect(google_timeago(3984)).toEqual("1h 6m")

