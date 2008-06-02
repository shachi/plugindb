// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function inj_c(val){
  tagitem = document.getElementById('tagged');
  tagitem.focus();
  tagitem.value += val
}