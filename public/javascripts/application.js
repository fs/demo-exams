// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function countdown(dom_id, seconds_left, callback) {
  if(seconds_left <= 0 && callback) {
    return callback();
  }
  
  var seconds = seconds_left;
  var minutes = Math.floor(seconds / 60);
  seconds %= 60;
  
  var mps = 's';
  var sps = 's';
  if(minutes == 1) mps ='';
  if(seconds == 1) sps ='';

  $(dom_id).update(minutes + ' minute' + mps + ' ' + seconds + ' second' + sps + ' left');
  
  setTimeout('countdown("' + dom_id + '", ' + (seconds_left - 1) + ', ' + callback + ');', 1000);
}
