#= require active_admin/base
#= require active_admin_flat_skin
#= require jquery.fancybox.min.js
$ ->
  $('a.fancybox').fancybox({type: 'ajax'})

###
$(document).on('ready page:load turbolinks:load', $ -> 
  $('a.lextest').click ((e) ->
    e.stopPropagation();
    e.preventDefault();

    ActiveAdmin.modal_dialog("Crear usuario: ", {name: 'text', last_name: 'text'}, (inputs) ->
      alert (inputs.name)
    );
  )
)
###