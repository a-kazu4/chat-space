$(document).on('turbolinks:load', function() {

  IncrementalSearch();
  clickAddButton();
  clickRemoveButton();

  function IncrementalSearch() {
    $('#user-search-field').on('keyup', function() {
      removeElementUnderSearchResult();
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
  }

  function clickAddButton() {
    $(document).on('click', '.chat-group-user__btn--add', function(e) {
      stopActionOfPushingButton(e);
      var aTagWithButton = this;
      var user = setUser(aTagWithButton);
      removePreviousButton(aTagWithButton);
      buildRemoveButton(user);
    })
  }

  function clickRemoveButton() {
    $(document).on('click', '.chat-group-user__btn--remove', function(e) {
      stopActionOfPushingButton(e);
      var aTagWithButton = this;
      var user = setUser(aTagWithButton);
      removePreviousButton(aTagWithButton);
      buildAddButton(user);
    })
  }

  function buildAddButton(user) {
    var getCurrentUserId = $('#get_current_user_id').attr('value');
    var getUserId = $('#get_user_id').attr('value');
    if (getCurrentUserId == user.id) {
      var addButton = '';
    } else if (getUserId == user.id) {
      var addButton = '';
    } else {
      var addButton = `<a class='user-search-add chat-group-user__btn chat-group-user__btn--add'>追加</a>`;
    }
    var html = `<div class='chat-group-user clearfix'>
                  <p class='chat-group-user__name'>${user.name}</p>
                  ${addButton}
                  <input type='hidden' name='group[user_ids][]' value='${user.id}'></input>
                </div>`;
    $('#user-search-result').append(html);
  }

  function buildRemoveButton(user) {
    var html = `<div class='chat-group-user clearfix'>
                  <p class='chat-group-user__name'>${user.name}</p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove'>削除</a>
                  <input type='hidden' name='group[user_ids][]' value='${user.id}' id='get_user_id'></input>
                </div>`;
    $('#registered_user').append(html);
  }

  function removeElementUnderSearchResult() {
    $('#user-search-result').children().remove();
  };

  function stopActionOfPushingButton(event) {
    event.preventDefault();
  };

  function setUser(aTagWithButton) {
    var user = {name: $(aTagWithButton).parent().find('p').html(), id: $(aTagWithButton).parent().find('input').attr('value')};
    return user
  };

  function removePreviousButton(aTagWithButton) {
    $(aTagWithButton).parent('div').remove();
  }

});
