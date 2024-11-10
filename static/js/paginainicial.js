
document.addEventListener("DOMContentLoaded", function() {
    // Select all elements with the class 'valor-produto'
    const valorProdutoElements = document.querySelectorAll('.valor-produto');
    
    // Loop through each element
    valorProdutoElements.forEach(function(element) {
      // Get the current content (price) of each element
      const price = element.innerHTML.trim();
      
      // Call the currency function and set the formatted value back
      const formattedPrice = currency(price);
      
      // If the price is valid (not NaN), update the innerHTML
      if (formattedPrice !== false) {
        element.innerHTML = 'R$ ' + formattedPrice;
      }
    });
  });