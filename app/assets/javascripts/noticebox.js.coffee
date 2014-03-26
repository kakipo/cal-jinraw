$(document).on("ready pjax:success", () ->

  do () ->
    # Message Area
    $('div.notify.alert')
      .css('cursor', 'pointer')
      .click(() -> $(this).hide() )
      .delay(1500).fadeOut(1000)
)