//Private variables
var colsDefault = 0;
var rowsDefault = 0;
//var rowsCounter = 0;

//Private functions
function setDefaultValues(txtArea)
{
	colsDefault = txtArea.cols;
	rowsDefault = txtArea.rows;
	//rowsCounter = document.getElementById("rowsCounter");
}

function bindEvents(txtArea)
{
	txtArea.onkeyup = function() {
		grow(txtArea);
	}
}

//Helper functions
function grow(txtArea)
{
    var linesCount = 0;
    var lines = txtArea.value.split('\n');

    for (var i=lines.length-1; i>=0; --i)
    {
        linesCount += Math.floor((lines[i].length / colsDefault) + 1);
    }

    if (linesCount >= rowsDefault)
        txtArea.rows = linesCount + 1;
	else
        txtArea.rows = rowsDefault;
	//rowsCounter.innerHTML = linesCount + " | " + txtArea.rows;
}

//Public Method
jQuery.fn.autoGrow = function(){
	return this.each(function(){
		setDefaultValues(this);
		bindEvents(this);
	});
};

