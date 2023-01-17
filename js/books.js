// var select = document.getElementById('selectSender');
// select.addEventListener('change', function() {

//   select.options[select.selectedIndex].setAttribute('selected');
// });

// let selects = document.getElementsByTagName('select');

// for (let i = 0; i < selects.length; ++i) {
//     let currentSelect = selects[i];
//     let selectedOption = currentSelect.querySelector('option[selected]');
//     if (selectedOption) currentSelect.value = selectedOption.value;
// }

// var country = document.getElementById("selectSender");
// console.log('country: ' + country.options[country.options.selectedIndex])
// country.options[country.options.selectedIndex].selected = true;

document.addEventListener('DOMContentLoaded', function() {
	console.log('DOMContentLoaded');
	if (document.getElementById('sortTitle')) { 
		document.getElementById('sortTitle').addEventListener("click", sortTable.bind(null, 0));
	}
	if (document.getElementById('sortYear')) {
		document.getElementById('sortYear').addEventListener("click", sortTable.bind(null, 1));
	}
	if (document.getElementById('sortAuthor')) {
		document.getElementById('sortAuthor').addEventListener("click", sortTable.bind(null, 2));
	}
	if (document.getElementById('sortDate')) {
		document.getElementById('sortDate').addEventListener("click", sortTable.bind(null, 0));
	}
	if (document.getElementById('sortSender')) {
		document.getElementById('sortSender').addEventListener("click", sortTable.bind(null, 1));
	}
	if (document.getElementById('sortReceiver')) {
		document.getElementById('sortReceiver').addEventListener("click", sortTable.bind(null, 2));
	}
	
	if (document.getElementById('letter-form')) {
		filterLetter()
    //document.forms['letter-form'].addEventListener("change", selectSender());
	}
	// if (document.getElementById('selectSender')) {
	// 	document.getElementById('selectSender').addEventListener("change", selectSender());
	// }
	// if (document.getElementById('selectReceiver')) {
	// 	document.getElementById('selectReceiver').addEventListener("change", selectSender());
	// }

	if (document.getElementById('selectAuthor')) {

	(function() {
		const author = document.getElementById("selectAuthor");
		const elements = document.querySelectorAll("tr.book-item");
		// Nedenstående linje virker også! Men author.addEventListener må være den
		// rigtige
		// selectAuthor.addEventListener("change", function() {
		author.addEventListener("change", function() {
			let value = author.value;
			[...elements].forEach((element) => {
				if (value === "") {
					//Select empty option
					element.classList.remove("hidden");
				} else {
					//Get the author for this list item
					const auth = element.dataset.author;
					console.log('author : ' + auth + ' value : '+ value)
					// Check if the author matches the value
					// If it doesn't
					if (!auth || auth != value) {
						//Hide the element
						element.classList.add("hidden");
					} else {
						// Show the element
						element.classList.remove("hidden");
					}
				}
			});
		});
	}())
	}
	// Slut

});

// var select = document.getElementById('selectSender')
// select.addEventListener('change', function() {
//   select.options[select.selectedIndex].setAttribute('selected');
// });

// Handle a collection of letters by enabling selection of sender and receiver

const letterForm = document.forms['letter-form']

letterForm.addEventListener('change', filterLetter, false) 
    function filterLetter () {
      const sender = document.getElementById('selectSender')
      const receiver = document.getElementById('selectReceiver')
      const elements = document.querySelectorAll('tr.book-item')

      // var b = document.getElementById('#selectSender');
      // b.options[b.options.selectedIndex].selected = true;

      // Nedenstående linje virker også! Men sender.addEventListener må være den
      // rigtige
      // selectAuthor.addEventListener("change", function() {
      // addEventListener("change", function() {
      let senderSelected = sender.value;
      let receiverSelected = receiver.value;
      //console.log('senderSelected: ' + senderSelected + '\n' + 'receiverSelected: ' + receiverSelected);
    [...elements].forEach((element) => {
        // Select empty option
        if (senderSelected === "" && receiverSelected === "" ) {
          element.classList.remove('hidden');
        } else {
          //Get the sender and receiver for this list item
          const sender = element.dataset.sender;
          const receiver = element.dataset.receiver;
          if (!senderSelected && receiver == receiverSelected ||
            !receiverSelected && sender == senderSelected) {
            element.classList.remove('hidden');
          } else
            // Check if the sender matches the value -- If it doesn't, hide it
            if(( (!senderSelected || sender != senderSelected) ||
              (!receiverSelected || receiver != receiverSelected))
            ) {
              element.classList.add('hidden'); 
            }
          else
          { 
            element.classList.remove('hidden'); 
          }
        }
      });
      //});
      // });
      // disable form submit
      //letterForm.onsubmit =evt=>evt.preventDefault();
    }


//function selectSender() {
//const sender = document.getElementById("selectSender");
//const receiver = document.getElementById("selectReceiver");
//          const elements = document.querySelectorAll("tr.book-item");
//          // Nedenstående linje virker også! Men sender.addEventListener må være den
//          // rigtige
//          // selectAuthor.addEventListener("change", function() {
//          sender.addEventListener("change", function() {
//              let value = sender.value;
//			  let recvalue = receiver.value;
//              [...elements].forEach((element) => {
//                  if (value === "" && recvalue == "") {
//                      //Select empty option
//                      element.classList.remove("hidden");
//                  } else {
//                      //Get the sender for this list item
//                      const sender = element.dataset.sender;
//					  const receiver = element.dataset.receiver;
//                      console.log('sender : ' + sender + ' selected_sender : '+ value)
//                      console.log('receiver : ' + receiver + ' selected_receiver : '+ recvalue)
//                      // Check if the sender matches the value
//                      // If it doesn't
//                      if ((!sender || sender != value) && (!receiver || receiver != recvalue)) {
//                          //Hide the element
//                          element.classList.add("hidden");
//                      } else {
//                          // Show the element
//                          element.classList.remove("hidden");
//                      }
//                  }
//              });
//          });
//}  
//function selectReceiver() {
//const author = document.getElementById("selectReceiver");
//          const elements = document.querySelectorAll("tr.book-item");
//          // Nedenstående linje virker også! Men author.addEventListener må være den
//          // rigtige
//          // selectAuthor.addEventListener("change", function() {
//          author.addEventListener("change", function() {
//              let value = author.value;
//              [...elements].forEach((element) => {
//                  if (value === "") {
//                      //Select empty option
//                      element.classList.remove("hidden");
//                  } else {
//                      //Get the author for this list item
//                      const auth = element.dataset.receiver;
//                      console.log('receiver : ' + auth + ' value : '+ value)
//                      // Check if the author matches the value
//                      // If it doesn't
//                      if (!auth || auth != value) {
//                          //Hide the element
//                          element.classList.add("hidden");
//                      } else {
//                          // Show the element
//                          element.classList.remove("hidden");
//                      }
//                  }
//              });
//          });
//}  
  function sortTable(n) {
      var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
      table = document.getElementById("bookItems");
  
      switching = true;
      //Set the sorting direction to ascending:
      dir = "asc";
      /*Make a loop that will continue until
    no switching has been done:*/
      while (switching) {
          //start by saying: no switching is done:
          switching = false;
          rows = table.rows;
          /*Loop through all table rows (except the
      first, which contains table headers):*/
          for (i = 1; i < (rows.length - 1); i++) {
              //start by saying there should be no switching:
              shouldSwitch = false;
              /*Get the two elements you want to compare,
        one from current row and one from the next:*/
              x = rows[i].querySelectorAll('td')[n];
              y = rows[i + 1].querySelectorAll('td')[n];
              /*check if the two rows should switch place,
        based on the direction, asc or desc:*/
              if (dir == "asc") {
                  if (x.dataset.sort > y.dataset.sort) {
					  //console.log('sort er: ' + y.dataset.sort);
                      //if so, mark as a switch and break the loop:
                      shouldSwitch= true;
                      break;
                  }
              } else if (dir == "desc") {
                  if (x.dataset.sort < y.dataset.sort) {
					  //console.log('sort er: ' + x.dataset.sort);
                      //if so, mark as a switch and break the loop:
                      shouldSwitch = true;
                      break;
                  }
              }
          }
          if (shouldSwitch) {
              /*If a switch has been marked, make the switch
        and mark that a switch has been done:*/
              rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
              switching = true;
              //Each time a switch is done, increase this count by 1:
              switchcount ++;
          } else {
              /*If no switching has been done AND the direction is "asc",
        set the direction to "desc" and run the while loop again.*/
              if (switchcount == 0 && dir == "asc") {
                  dir = "desc";
                  switching = true;
              }
          }
      }
  }


//(function() {
//	const author = document.getElementById("selectAuthor");
//	const elements = document.querySelectorAll("tr.book-item");
	// Nedenstående linje virker også! Men author.addEventListener må være den
	// rigtige
	// selectAuthor.addEventListener("change", function() {
//	author.addEventListener("change", function() {
//		let value = author.value;
//		[...elements].forEach((element) => {
//			if (value === "") {
//				//Select empty option
//				element.classList.remove("hidden");
//			} else {
//				//Get the author for this list item
//				const auth = element.dataset.author;
//				console.log('author : ' + auth + ' value : '+ value)
//				// Check if the author matches the value
//				// If it doesn't
//				if (!auth || auth != value) {
//					//Hide the element
//					element.classList.add("hidden");
//				} else {
//					// Show the element
//					element.classList.remove("hidden");
//				}
//			}
//		});
//	});
//}())
