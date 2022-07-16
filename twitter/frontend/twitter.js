const FollowToggle = require('./follow_toggle');

$(function () {
  $('button.follow-toggle').each( (_, btn) => new FollowToggle(btn, {}) );
});
