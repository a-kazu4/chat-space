$(document).on('turbolinks:load', function() {

  function buildAddButton(user) {
    var html = `<div class='chat-group-user clearfix'>
                  <p class='chat-group-user__name'>${user.name}</p>
                  <a class='user-search-add chat-group-user__btn chat-group-user__btn--add' data-user-id='${user.id}' data-user-name='${user.name}'>追加</a>
                </div>`;
    $('#user-search-result').append(html);
  }


  $('#user-search-field').on('keyup', function() {
    $('#user-search-result').children().remove();
    var input = $('#user-search-field').val();
    $.ajax({
      url:      '/users/search',
      type:     'GET',
      data:     {keyword: input},
      datatype: 'json'
    })
    .done(function(users) {
      if (users.length !== 0) {
        users.forEach(function(user) {
          buildAddButton(user);
        });
      }
      $('#user-search-field').val();
    })
    .fail(function() {
      alert('検索に失敗しました。')
    })
  });
});
