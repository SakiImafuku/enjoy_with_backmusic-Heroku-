/*=== PLAYER ===*/
jQuery(document).ready(function($) {
  audiojs.events.ready(function() {
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
});

/*=== User_tab ===*/
jQuery(document).ready(function($) {
  $(window).on('load', function(){
    if (document.URL.match('/following')){
      console.log('following');
      $('.following_list').addClass('active');
      $('.following_list').siblings.removeClass('active');
    }
    if (document.URL.match('/followers')){
      console.log('followers');
      $('.followers_list').addClass('active');
      $('.followers_list').siblings.removeClass('active');
    }
  });
});
