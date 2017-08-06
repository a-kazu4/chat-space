$(document).on('turbolinks:load', function() {

  function buildHTML(message){
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

  $('#new_message_form').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData($('#new_message_form').get(0));
    $('.chat__footer__send').removeAttr('data-disable-with');
    $.ajax({
      url: location.href,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      buildHTML(data);
      $('.chat__footer__input__body').val('');
      $('.file-upload').val('');
    })
    .fail(function(){
      alert('メッセージを送信できませんでした。');
    })
  });
});
