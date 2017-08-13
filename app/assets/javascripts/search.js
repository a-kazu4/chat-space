$(document).on('turbolinks:load', function() {

  function buildAddButton(user) {
    var html = `<div class='chat-group-user clearfix'>
                  <p class='chat-group-user__name'>${user.name}</p>
                  <a class='user-search-add chat-group-user__btn chat-group-user__btn--add' data-user-id='${user.id}' data-user-name='${user.name}'>追加</a>
                </div>`;
    $('#user-search-result').append(html);
  }

  function buildRemoveButton(user) {
    var html = `<div class='chat-group-user clearfix'>
                  <p class='chat-group-user__name'>${user.name}</p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove' data-user-id='${user.id}' data-user-name='${user.name}'>削除</a>
                </div>`;
    $('#registered').append(html);
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
  })

  $(document).on('click', '.chat-group-user__btn--add', function(e) {
    e.preventDefault();
    var user = {name: $(this).attr('data-user-name'), id: $(this).attr('data-user-id')};
    buildRemoveButton(user);
    $(this).parent("div").remove();
  })

  $(document).on('click', '.chat-group-user__btn--remove', function(e) {
    e.preventDefault();
    var user = {name: $(this).attr('data-user-name'), id: $(this).attr('data-user-id')};
    buildAddButton(user);
    $(this).parent('div').remove();
  })
});
