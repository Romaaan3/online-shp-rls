// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require maskedinput
//= require tinymce
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require jquery_nested_form
//= require_tree .

$('.dropdown-toggle').dropdown();

$("#part_search input[type=\"search\"").bind('keyup', function(){
	$(this).parent().submit();
});


$("[data-mask]").each(function(index, value) {
  var element;
  element = $(value);
  return element.mask($(value).data('mask'));
});
