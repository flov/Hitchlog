describe "timeago", ->
  beforeEach ->
    @from_time = new Date("12 July, 2013")
    @to_time = new Date("12 July, 2013")

  it "should return `5m` for five minutes", ->
    @to_time.setMinutes(@from_time.getMinutes() + 5);
    expect(timeago(@from_time, @to_time)).toEqual("5m")

  it "should return `5h` for five hours", ->
    @to_time.setHours(@to_time.getHours() + 5);
    expect(timeago(@from_time, @to_time)).toEqual("5h")

  it "should return `29d` for 29 days", ->
    @to_time.setDate(@from_time.getDate() + 29);
    expect(timeago(@from_time, @to_time)).toEqual("29d")

  it "should return `1d 3h 20m`", ->
    @to_time.setDate(@from_time.getDate() + 1);
    @to_time.setHours(@from_time.getHours() + 3);
    @to_time.setMinutes(@from_time.getMinutes() + 20);
    expect(timeago(@from_time, @to_time)).toEqual("1d 3h 20m")

  it "should return empty string if time is longer than a month", ->
    @to_time.setUTCFullYear(@from_time.getUTCFullYear() + 1);
    expect(timeago(@from_time, @to_time)).toEqual("")
