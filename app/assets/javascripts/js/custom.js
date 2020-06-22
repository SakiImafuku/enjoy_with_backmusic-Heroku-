/*=== PLAYER ===*/
jQuery(document).on('turbolinks:load', function() {
  var a = audiojs.createAll();
  let audio = a[0];
  const $playPauseButton = $(".play_pause_button");
  const $selectMusicpostPlay = $(".select_musicpost_play");
  const $selectMusicpostPause = $(".select_musicpost_pause");
  $('.audiojs').css('display', 'none');

  $selectMusicpostPlay.click(function(){
    $('.audiojs').css('display', 'block');
    if($(this).parent().hasClass("select")){
      audio.play();
    } else {
      $playPauseButton.removeClass("select");
      $(this).parent().addClass("select");
      $('audio').attr('src', $(this).children('.src').val());
      $('.music_information').children('.title').text($(this).children('.title').val());
      $('.music_information').children('.upload_user').text($(this).children('.upload_user').val());
      audio.play();
    }
    $selectMusicpostPlay.css('display', 'block');
    $selectMusicpostPause.css('display', 'none');
    $(this).css('display', 'none');
    $(this).siblings().css('display', 'block');
  });

  $selectMusicpostPause.click(function(){
    audio.pause();
    $selectMusicpostPlay.css('display', 'block');
    $selectMusicpostPause.css('display', 'none');
  });

  $('.play').click(function(){
    selectMusicpost = $(".select");
    console.log(selectMusicpost);
    selectMusicpost.children(".select_musicpost_play").css('display', 'none');
    selectMusicpost.children(".select_musicpost_pause").css('display', 'block');
  })
  $('.pause').click(function(){
    $selectMusicpostPlay.css('display', 'block');
    $selectMusicpostPause.css('display', 'none');
  })
});

/*=== User_tab ===*/
jQuery(document).on('turbolinks:load', function() {
    if (document.URL.match('/following')){
      $('.following_list').addClass('active');
    }
    if (document.URL.match('/followers')){
      $('.followers_list').addClass('active');
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
    console.log(1);
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("5MB以下のファイルを選択してください。");
      $("#user_avatar").val("");
    }
  });
});
