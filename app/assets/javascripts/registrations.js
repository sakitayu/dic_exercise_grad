// disc_large_sentenceのフェードインアニメ

$(function () {
  $('.disc_large_sentence').textillate({loop: true});
})

$(function () {
    $('.disc_large_sentence').css('opacity',1).textillate({
      loop: false,  
      minDisplayTime: 0,  
      initialDelay: 150,  
      autoStart: true,  

      in:{
        effect: 'fadeIn',  
        delayScale: 10.5,  
        delay: 40,  
        sync: true,  
        shuffle: false
      },  

      out:{
        effect: 'fadeOut',  
        delayScale: 1.5,  
        delay: 50,  
        sync: false,  
        shuffle: false
      }
    });
})

// disc_small_sentence_1のフェードインアニメ

$(function () {
    $('.disc_small_sentence_1').textillate({loop: true});
})

$(function () {
    $('.disc_small_sentence_1').css('opacity',1).textillate({
      loop: false,  
      minDisplayTime: 0,  
      initialDelay: 600,  
      autoStart: true,  

      in:{
        effect: 'fadeIn',  
        delayScale: 10.5,  
        delay: 40,  
        sync: true,  
        shuffle: false
      },  

      out:{
        effect: 'fadeOut',  
        delayScale: 1.5,  
        delay: 50,  
        sync: false,  
        shuffle: false
      }
    });
})

// disc_small_sentence_2のフェードインアニメ

$(function () {
    $('.disc_small_sentence_2').textillate({loop: true});
})

$(function () {
    $('.disc_small_sentence_2').css('opacity',1).textillate({
      loop: false,  
      minDisplayTime: 0,  
      initialDelay: 1000,  
      autoStart: true,  

      in:{
        effect: 'fadeIn',  
        delayScale: 10.5,  
        delay: 40,  
        sync: true,  
        shuffle: false
      },  

      out:{
        effect: 'fadeOut',  
        delayScale: 1.5,  
        delay: 50,  
        sync: false,  
        shuffle: false
      }
    });
})

// disc_small_sentence_3のフェードインアニメ

$(function () {
    $('.disc_small_sentence_3').textillate({loop: true});
})

$(function () {
    $('.disc_small_sentence_3').css('opacity',1).textillate({
      loop: false,  
      minDisplayTime: 0,  
      initialDelay: 1400,  
      autoStart: true,  

      in:{
        effect: 'fadeIn',  
        delayScale: 10.5,  
        delay: 40,  
        sync: true,  
        shuffle: false
      },  

      out:{
        effect: 'fadeOut',  
        delayScale: 1.5,  
        delay: 50,  
        sync: false,  
        shuffle: false
      }
    });
})