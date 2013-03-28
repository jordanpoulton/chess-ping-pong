$(function() {
  $("#world-rankings").click(function() {
    if ($("#dialog-message").length == 0) return;
    $( "#dialog-message" ).dialog({
      width: 800,
      height: 600,
      modal: true,
      buttons: {
        Ok: function() {
          $( this ).dialog( "close" );
        },
        More: function() {
          window.location = "/world_ranking"
          $(id).click();
        }
      }
    });
    return false;
  });
});
