//= require jquery-1.8.3.min
//= require jquery.timeago
//= require jquery.timeago.zh-CN
//= require highlight.min

hljs.initHighlightingOnLoad();

$(function() {
  $('.meta-time time').timeago();
});