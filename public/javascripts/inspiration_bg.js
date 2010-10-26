// I get the day of the month to fill in the background image with the day's picture from http://inspiration.sweyla.com/
// it changes every hour
$(
	function(){
    var today=new Date()
    $('body').css('background', 'url(http://inspiration.sweyla.com/image/'+today.getDate()*today.getYear()*today.getHours()+'.png)')
})