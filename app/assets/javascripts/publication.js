$(function(){
  $('.toggle').hide();
  $('.article_toggle').click(function(){
    $('.toggle').slideToggle("slow", function(){

    });
  });
});