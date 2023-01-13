//
// Document ready function 
//

$(function(){
	// attach click functionality to annotation controls
	//$('#person-note-checkbox').click(function(event)) {colorAllNotes(this,'.name','#EDD19F')};
	$('#person-note-checkbox').click(function(event) {colorAllNotes(this,'.name','#EDD19F');});
	$('#text-critical-note-checkbox').click(function(event) {colorAllTextCriticalNotes(this,'.btn-outline-secondary','blue');});
});

//
// Toggle inline notes in text (as found in brandes project (static/javascript.js))
//

function colorAllNotes(checkbox, note_class, background_color) {
  if (checkbox.checked) {
    $(note_class).each(function() {
      $(this).css({
        'backgroundColor': background_color,
        cursor: 'pointer'
      });
    });
    setCookie(note_class, 'checked', 365);
  } else {
    $(note_class).each(function() {
      $(this).css({
        'backgroundColor': 'transparent',
        cursor: 'default'
      });
    });
    setCookie(note_class, '', 365);
  }
}

//
// Toggle text-critical notes
//

function colorAllTextCriticalNotes(checkbox, note_class, background_color) {
  if (checkbox.checked) {
    $(note_class).each(function() {
      $(this).css({
        color: background_color,
        display: 'inline',
        cursor: 'pointer'
      });
      $(this).removeClass('hidden');
    });
    setCookie(note_class, 'checked', 365);
  } else {
    $(note_class).each(function() {
      $(this).css({
        display: 'none',
        cursor: 'default'
      });
    });
    setCookie(note_class, '', 365);
  }
}

function setCookie(name,value,days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days*24*60*60*1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "")  + expires + "; path=/";
}

//
// Table og Contents menu for each text
//

$(document).ready(function(){

  $('#text-nav-toggle-toc').click(function() {
    if($('#toggle-toc').is(":hidden")) { $('#toggle-toc').show(); }
    else { $('#toggle-toc').hide(); }
       return false;
  });
  
  $(function () {
    $('[data-toggle="popover"]').popover()
  });


});

// Modal example

$('#myModal').on('shown.bs.modal', function(event) {
  // reset the scroll to top
  $('#myModal .modal-body').scrollTop(0);
  // get the section using data
  var section = $(event.relatedTarget).data('section');
  // get the top of the section
  var sectionOffset = $('#' + section).offset();
  //scroll the container
  $('#myModal .modal-body').animate({
    scrollTop: sectionOffset.top - 30
  }, "slow");
});

//$(function () {
//  $('[data-toggle="popover"]').popover()
//})

function showNote(){
  var myId = $(this).attr("id");
  //var myId = 'App1'
  var popup = document.getElementById(myId);
  popup.classList.toggle("show");
}

const button = document.querySelector('#button');
      const tooltip = document.querySelector('#tooltip');

      let popperInstance = null;

      function create() {
        popperInstance = Popper.createPopper(button, tooltip, {
          modifiers: [
            {
              name: 'offset',
              options: {
                offset: [0, 8],
              },
            },
          ],
        });
      }

      function destroy() {
        if (popperInstance) {
          popperInstance.destroy();
          popperInstance = null;
        }
      }

      function show() {
        tooltip.setAttribute('data-show', '');
        create();
      }

      function hide() {
        tooltip.removeAttribute('data-show');
        destroy();
      }

      const showEvents = ['mouseenter', 'focus'];
      const hideEvents = ['mouseleave', 'blur'];

      showEvents.forEach(event => {
        button.addEventListener(event, show);
      });

      hideEvents.forEach(event => {
        button.addEventListener(event, hide);
      });

//
// Authors dropdown list
//
/*function authorsDDFunction() {
  document.getElementById("authorsDD").classList.toggle("show");
}*/

/*function filterFunction() {
  var input, filter, ul, li, a, i;
  input = document.getElementById("authorsDDInput");
  filter = input.value.toUpperCase();
  div = document.getElementById("authorsDropdown");
  a = div.getElementsByTagName("a");
  for (i = 0; i < a.length; i++) {
    txtValue = a[i].textContent || a[i].innerText;
    if (txtValue.toUpperCase().indexOf(filter) > -1) {
      a[i].style.display = "";
    } else {
      a[i].style.display = "none";
    }
  }
}*/
