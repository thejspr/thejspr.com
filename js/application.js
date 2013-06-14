$(document).ready(function(){
  var height = Math.max($(window).height(), $('#content').height());
  $('#sidebar').css({'min-height': height});
});
