// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
Event.observe(window, 'load', function() {
  var e = $A(document.getElementsByTagName('*')).find(function(e) {
    return (e.tagName.toUpperCase() == 'INPUT' && (e.type == 'text' || e.type == 'password'))
        || e.tagName.toUpperCase() == 'TEXTAREA';
  });
  if (e) e.focus();
});

