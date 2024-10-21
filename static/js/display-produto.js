function currency(n) {
  n = parseFloat(n);
  return isNaN(n) ? false : n.toFixed(2);
}
var precoFormatado = currency(preco);
document.getElementById("valor-prod").innerHTML = "R$" + precoFormatado;
