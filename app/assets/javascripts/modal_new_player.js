$(function() {
  $("#new-player").click(function() {
    $( "#dialog-message-new-player" ).dialog({
      width: 800,
      height: 800,
      modal: true,
      buttons: {
        Onwards: function() {
          $("#new_player_signup_form form").submit();
        },
      }
    });
    return false;
  });

  $("select#match_opponent").change(function(e) {
    if ($(this).val() === "0") {
      $("#new-player").click();
    }
  })

  $("select#match_player").change(function(e) {
    if ($(this).val() === "0") {
      $("#new-player").click();
    }
  })

});

