$(document).on('turbolinks:load', function() {

  function buildHTML(message){
    var html = `<div class='chat__body__chat'>
                  <div class='chat__body__chat__top'>
                    <div class='chat__body__chat__top__name'>${message.name}</div>
                    <div class='chat__body__chat__top__time'>${message.time}</div>
                  </div>
                  <div class='chat__body__chat__bottom'>
                    <div class='chat__body__chat__bottom__message'>`;
    var insertBody = `${message.body}</div></div></div>`;
    var insertImage = `<img src="${message.image}"></div></div></div>`;
    var insertBoth = `${message.body} <br> <img src="${message.image}"></div></div></div>`;

    if ( message.image == undefined ) {
      html += insertBody;
    } else if ( message.body == undefined ) {
      html += insertImage;
    } else {
      html += insertBoth;
    }
    $('.chat__body').append(html);
  };

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
    })

    .fail(function(){
      alert('メッセージを送信できませんでした。');
    });
  });
});
