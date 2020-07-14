// This function is used on the Attendace page
// By clicking the 'Emergency Contact' button
// It will display an array with all the phone
// numbers that a child has for Emergency
// each of them contain: the number and the
// relationship that the person has with the child
// e.g. 0908876677 Parent 
$(document).ready(function(){
  $('[data-show-phone-number-for]').on('click', function(){
    $(this).hide();
    childId = $(this).data('show-phone-number-for');
    $('.phone-number-for-' + childId).show();
  })
});
