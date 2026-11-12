// Phones: close the menu of the navbar toggle once a tab is chosen in it, so that the
// tab is seen at once (Bootstrap 3 leaves the menu open over the top of the page).
// On a desktop the menu is never collapsed, so this does nothing there.
$(document).on('click', '.navbar-collapse.in a[data-toggle="tab"], .navbar-collapse.in a[data-bs-toggle="tab"]', function() {
  $(this).closest('.navbar-collapse').collapse('hide');
});
