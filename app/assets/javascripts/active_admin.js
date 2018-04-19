/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
*/
//= require active_admin/base
//= require active_admin_flat_skin
//= require jquery.fancybox.min
//= require chartkick

$(
    () => $('a.fancybox').fancybox({type: 'ajax'})
);

$( document ).ready( ()=>{
    let password_fields = $('fieldset.password_fields');
    if (!($('#user_change_password').prop('checked'))){
        password_fields.css('display', 'none') ;
    }

    $('#user_change_password').on("change", () => {
        password_fields.toggle(500);
    } );

    $('a.cancel_confirm').on("click", () => {
        $.fancybox.close();
    })
})