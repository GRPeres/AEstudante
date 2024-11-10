function currency(n) {
    n = parseFloat(n);
    return isNaN(n) ? false : n.toFixed(2);
  }  
