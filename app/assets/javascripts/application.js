// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
  var home = $('.home');
  var root = home.data().homepage;
  var user = $('.user_name');
  user.hover(function(){
    user.css('cursor','help');
  });
  home.hover(function(){
    home.css('cursor','wait');
  });
  user.click(function(){
    window.location.replace(root);
  });
  home.click(function(){
    window.location.replace(root);
  })
});

$(function () {

  $("form#stripe_form").submit(function (e) {
    e.preventDefault();

    Stripe.card.createToken({
      number: $('#credit_card_number').val(),
      cvc: $('#cvv').val(),
      exp_month: $('#_expiry_date_2i').val(),
      exp_year: $('#_expiry_date_1i').val()
    }, stripeResponseHandler);

    function stripeResponseHandler(status, response) {
      if (response.error) {
        // show the errors on the form
        $(".payment-errors").text(response.error.message);
      } else {
        var $form = $(e.target);
//    // token contains id, last4, and card type
        var token = response['id'];
//    // insert the token into the form so it gets submitted to the server
        $form.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
//    // and submit
        $('#credit_card_number').removeAttr('name');
        $('#cvv').removeAttr('name');
        $form.get(0).submit();

      }
    }
  });
});


