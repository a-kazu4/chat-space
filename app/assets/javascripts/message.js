$(document).on('turbolinks:load', function() {

  asynchronousCommunication();

  function asynchronousCommunication() {
    $('#new_message_form').on('submit', function(e) {
      var formData = new FormData($('#new_message_form').get(0));
      var urlOfThisPage = location.href;
      removeUnnecessaryAttr();
      stopActionOfPushingSendButton(e);
      $.ajax({
        url: urlOfThisPage,
        type: 'POST',
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(data) {
        buildHTML(data);
        formClearForContinuousPost();
      })
      .fail(function() {
        alert('メッセージを送信できませんでした。');
      })
    });
  }

  function buildHTML(message) {
    var insertBody = `${message.body}`;
    var insertImage = `<img src='${message.image}', alt='${message.image}'>`;
    var insertBodyAndImage = `${message.body} <br> <img src='${message.image}', alt='${message.image}'>`;

    if ( message.image == undefined ) {
      var chatBottom = insertBody;
    } else if ( message.body == undefined ) {
      var chatBottom = insertImage;
    } else {
      var chatBottom = insertBodyAndImage;
    }

    var html = `<div class='chat__body__chat'>
                  <div class='chat__body__chat__top'>
                    <div class='chat__body__chat__top__name'>${message.name}</div>
                    <div class='chat__body__chat__top__time'>${message.time}</div>
                  </div>
                  <div class='chat__body__chat__bottom'>
                    <div class='chat__body__chat__bottom__message'>${chatBottom}</div>
                  </div>
                </div>`;

    $('.chat__body').append(html);
  }

  function stopActionOfPushingSendButton(event) {
    event.preventDefault();
  };

  function removeUnnecessaryAttr() {
    $('.chat__footer__send').removeAttr('data-disable-with');
  };

  function formClearForContinuousPost() {
    $('.chat__footer__input__body').val('');
    $('.file-upload').val('');
  };
});
