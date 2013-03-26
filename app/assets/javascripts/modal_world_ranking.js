$(function() {
  $("#world-rankings").click(function() {
    $( "#dialog-message" ).dialog({
      width: 800,
      height: 600,
      modal: true,
      buttons: {
        Ok: function() {
          $( this ).dialog( "close" );
        }
      }
    });
    return false;
  });
});
