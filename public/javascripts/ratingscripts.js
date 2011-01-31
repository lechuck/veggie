// Sets up the stars to match the data when the page is loaded.
$(function () {
    var checkedId = $('form.rating_ballot > div.field > input:checked').attr('id');
    $('form.rating_ballot > div.field > label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright');
});

$(document).ready(function() {
    // Makes stars glow on hover.
    $('form.rating_ballot > .field > label').hover(
        function() {    // mouseover
            $(this).prevAll().andSelf().addClass('glow');
        },function() {  // mouseout
            $(this).siblings().andSelf().removeClass('glow');
    });

    // Makes stars stay glowing after click.
    $('form.rating_ballot > .field > label').click(function() {
        $(this).siblings().removeClass("bright");
        $(this).prevAll().andSelf().addClass("bright");
    });

});

/* Slides down rating-form in views/restaurant/show.html.erb */
$(document).ready(function(){
$("#add_review").click(function(){
    $("#ratings_form").slideDown("slow");
    $('#add_review').hide();
  });
});

/* Slides up rating-form in views/restaurant/show.html.erb */
$(document).ready(function(){
$(".toggle_ratings_form").click(function(){
    $("#ratings_form").slideUp("slow");
    $("#add_review").show();
  });
});
