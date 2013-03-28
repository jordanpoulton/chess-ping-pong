$(function() {
  $("#login").click(function() {
    $( "#dialog-message-login-player" ).dialog({
      width: 800,
      height: 500,
      modal: true,
      buttons: {
        Onwards: function() {
          $("#login-form form").submit();
        },
      }
    });
    return false;
  });
});
