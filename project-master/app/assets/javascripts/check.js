// This function is used on the Coach Registration form
// When checking the thickbox, it will display:
// The DBS expiration date
// The First Aid expiration date
// And the safeguarding expiration date
$(document).ready(function(){

    $("#registerbutton").hide();
    $("#expiration-date").hide();
    $("#first-aid").hide();
    $("#safeguarding").hide();
    $("#application").action = "application";
    $("#redirect-text").show();
    $('input[type="checkbox"]').click(function(){
        // When the thickbox is not checked
        // All the expiration date filds will disappear
        if($(this).is(":not(:checked)")){
            $("#selfdeclaration").show();
            $("#registerbutton").hide();
            $("#expiration-date").hide();
            $("#first-aid").hide();
            $("#safeguarding").hide();
            $("#redirect-text").show();
            $("#application").attr('action', 'self_declaration')
        }
        // As stated above, this will show the fields about 
        // expiration dates
        else if($(this).is(":checked")){
            $("#selfdeclaration").hide();
            $("#registerbutton").show();
            $("#expiration-date").show();
            $("#first-aid").show();
            $("#safeguarding").show();
            $("#redirect-text").hide();
            $("#application").attr('action', 'application');
        }
    });
});
