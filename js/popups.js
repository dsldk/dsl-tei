// Popups.js
//

function toggle(element) {
  if (element.style.display == 'none') {
    element.style.display = 'block';
  }
  else {
    element.style.display = 'none';
    element.style.visibility = 'visible';
  }
}
