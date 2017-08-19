$(document).on('turbolinks:load', function() {

  asynchronousCommunication();
  automaticUpdating();

  function automaticUpdating() {
    var pathOfThisPage = location.pathname;
    var group_id = $('#get_group_id').attr('data_group_id');
    if (pathOfThisPage == '/group/' + group_id + '/messages') {
      var urlOfThisPage = location.href;
      $.ajax({
        type: 'GET',
        url: urlOfThisPage,
        dataType: 'json'
      })
      .done(function(messages) {
        messages.forEach(function(message) {
          buildHTML(message);
        });
      })
      .fail(function() {
        alert('自動更新に失敗しました')
      })
    } else {
      clearInterval(interval);
    }
  };

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

    var html = `<div class='chat__body__chat' data-message-id="${message.id}">
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

  var interval = setInterval(automaticUpdating(), 1000 * 5);

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
