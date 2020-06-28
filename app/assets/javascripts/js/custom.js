/*=== PLAYER ===*/
jQuery(document).ready(function($) {
  var a = audiojs.createAll();
  let audio = a[0];
  $('.audiojs').css('display', 'none');

  // 一覧の再生／停止ボタンをクリック
  $(document).on('click', '.select_musicpost_play', function(){
    $('.audiojs').css('display', 'block');
    if($(this).parent().hasClass("select")){
      audio.play();
    } else {
      $(".play_pause_button").removeClass("select");
      $(this).parent().addClass("select");
      audio.load($(this).children('.src').val());
      $('.music_information').children('.title').text($(this).children('.title').val());
      $('.music_information').children('.upload_user').text($(this).children('.upload_user').val());
      audio.play();
    }
    $(".select_musicpost_play").css('display', 'block');
    $(".select_musicpost_pause").css('display', 'none');
    $(this).css('display', 'none');
    $(this).siblings().css('display', 'block');
  });
  $(document).on('click', '.select_musicpost_pause', function(){
    audio.pause();
    $(".select_musicpost_play").css('display', 'block');
    $(".select_musicpost_pause").css('display', 'none');
  });

  // プレーヤーの再生／停止ボタンをクリック
  $(document).on('click', '.play', function(){
    $selectMusicpost = $(".select");
    $selectMusicpost.children(".select_musicpost_play").css('display', 'none');
    $selectMusicpost.children(".select_musicpost_pause").css('display', 'block');
  })
  $(document).on('click', '.pause', function(){
    $(".select_musicpost_play").css('display', 'block');
    $(".select_musicpost_pause").css('display', 'none');
  })

  // 並び替えを行う
  $('#order_select').change(function(){
    selectMusicpostId = $(".select").attr('id');
    $(".play_pause_button").removeClass("select");
    audio.pause();
    $.ajax({
      url: '/',
      type: 'GET',
      data: {
        order: $(this).val()
      }
    })
    .done(function (html) {
      $('.musicpost_index').html($('.musicpost_index', $(html)).html());
      $('footer').html($('footer', $(html)).html());
      $('#' + selectMusicpostId).addClass("select");
    })
    .fail(function (html) {
    })
  })
});

/*=== Tab ===*/
jQuery(document).ready(function($) {
  if (document.URL.match('/memos')){
    $('.memo_list').addClass('active');
  } else if (document.URL.match('/musicposts')){
    $('.comment_list').addClass('active');
  }
  if (document.URL.match('/favorites')){
    $('.favorites_list').addClass('active');
  }
  if (document.URL.match('/following')){
    $('.following_list').addClass('active');
  }
  if (document.URL.match('/followers')){
    $('.followers_list').addClass('active');
  }
});

/*=== User_relationship ===*/
jQuery(document).ready(function($) {
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
    console.log(1);
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("5MB以下のファイルを選択してください。");
      $("#user_avatar").val("");
    }
  });
});
