/*=== PLAYER ===*/
jQuery(document).on('turbolinks:load', function() {
  audiojs.events.ready(function(){
    audiojs.instanceCount = 0;
    let a = audiojs.createAll(),
        audio = a[0];
    $('.audiojs').css('display', 'none');
    // 一覧の再生ボタンをクリック
    $(document).on('click', '.select_musicpost_play', function(){
      if($(this).parent().hasClass("select")){
      } else {
        $('.play_pause_button').removeClass("select");
        $(this).parent().addClass("select");
        audio.load($(this).find('.src').val());
        $('audio').attr('src', $(this).find('.src').val());
        $('.music_information').find('.title').text($(this).find('.title').val());
        $('.music_information').find('.upload_user').text($(this).find('.upload_user').val());
      }
      $('.audiojs').css('display', 'block');
      $('.select_musicpost_play').css('display', 'block');
      $('.select_musicpost_pause').css('display', 'none');
      $(this).css('display', 'none');
      $(this).siblings().css('display', 'block');
      audio.play();
    });
    // 一覧の一時停止ボタンをクリック
    $(document).on('click', '.select_musicpost_pause', function(){
      audio.pause();
      $('.select_musicpost_play').css('display', 'block');
      $('.select_musicpost_pause').css('display', 'none');
    });
    // プレーヤーの再生／停止ボタンをクリック(プレイヤーの再生／一時停止はaudiojsで切り替わる)
    $(document).on('click', '.play', function(){
      $('.select').children('.select_musicpost_play').css('display', 'none');
      $('.select').children('.select_musicpost_pause').css('display', 'block');
    })
    $(document).on('click', '.pause', function(){
      $('.select_musicpost_play').css('display', 'block');
      $('.select_musicpost_pause').css('display', 'none');
    })
    // 並び替えを行う
    $('#order_select').change(function(){
      audio.pause();
      $('.now_loading').removeClass('hide');
      $.ajax({
        url: '/',
        type: 'GET',
        data: {
          order: $(this).val(),
          page: 1
        }
      })
      .done(function (html) {
        history.replaceState('','','/');
        $('.musicpost_index').html($('.musicpost_index', $(html)).html());
        $('.pagination').html($('.pagination', $(html)).html());
        $('.now_loading').addClass('hide');
      })
      .fail(function (html) {
        console.log(html)
      })
    })
  });
});

/*=== Tab ===*/
jQuery(document).on('turbolinks:load', function() {
  if (document.URL.match('/memos')){
    $('.memo_list').addClass('active');
  } else if (document.URL.match('/musicposts')){
    $('.comment_list').addClass('active');
  }
  if (document.URL.match('/favorites')){
    $('.favorites_list').addClass('active');
    return;
  }
  if (document.URL.match('/following')){
    $('.following_list').addClass('active');
    return;
  }
  if (document.URL.match('/histories')){
    $('.histories_list').addClass('active');
    return;
  }
  if (document.URL.match('/followers')){
    $('.followers_list').addClass('active');
    return;
  }
  if (document.URL.match('/favorites')){
    $('.favorites_list').addClass('active');
    return;
  }
  if (document.URL.match('/comments')){
    $('.comments_list').addClass('active');
    return;
  }
  if (document.URL.match('/users')){
    $('.upload_list').addClass('active');
  }
});

/*=== User_relationship ===*/
jQuery(document).on('turbolinks:load', function() {
  // 最初はフォローボタン非表示（cssで設定するとクリックしたときに消えてしまう）
  $('.user_relationship').find('.btn').css('display', 'none');
  // hoverしたときにフォローボタンを表示
  $('.user_relationship').hover(
    function(){
      $(this).find('.btn').css('display', 'block');
    },
    function(){
      $(this).find('.btn').css('display', 'none');
    }
  );
});

/*=== AvatarCheck ===*/
jQuery(document).ready(function($) {
  $("#user_avatar").bind("change", function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("5MB以下のファイルを選択してください。");
      $("#user_avatar").val("");
    }
  });
});
