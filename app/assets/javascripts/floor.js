// Here's some data.
var data = [
  ["http://www.google.com/" , "356,129,385,187"],
  ["https://www.youtube.com/" , "71,97,101,154"],
  ["http://www.isitajewishholidaytoday.com/", "102,261,133,283"]
];

// Here's a function that formats data
// passed to it in the above format
// as a table. The HTML is returned
// as a string.

function createTable(data) {
    var html = '';

    html += '<map name="Map" id="Map">';

    // Step through the rows of the data.
    for (var i = 0; i < 3; i++){
        html += '<area alt="" title="" href=' + data[i][0] + ' shape="rect" coords=' + data[i][1] +  '/>';
    }

    html += '</map>';

    return html;
}

// This function takes the formatted HTML
// and inserts it into the document as
// 'child' HTML of the specified element.
function insertHTML(id, html) {
    //var el = document.getElementById(id);
    document.getElementById(id).innerHTML = html;
}

// This function ties things up.
function run() {
    var html = createTable(data);

    insertHTML("floor", html);
}


window.onload = run();
