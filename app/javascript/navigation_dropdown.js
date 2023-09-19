document.addEventListener('turbo:load', function () {
    const dropdownNavbarButton = document.querySelector('#dropdownNavbarLink');
    const dropdownNavbarComponent = document.querySelector('#dropdownNavbar');
    
    if (dropdownNavbarButton && dropdownNavbarComponent) {
    dropdownNavbarButton.addEventListener('click', function () {
      dropdownNavbarComponent.classList.toggle('show');
    });
  
    // Close the dropdown if the user clicks outside of it
    window.addEventListener('click', function (event) {
      if (!event.target.matches('#dropdownNavbarLink')) {
        const openDropdown = document.querySelector('#dropdownNavbar.show');
        if (openDropdown) {
          openDropdown.classList.remove('show');
        }
      }
    });
  }
});
