// Seleciona todos os elementos com a classe 'hover-target'
const hoverTargets = document.querySelectorAll(".hover-target");

// Itera sobre cada elemento para adicionar os eventos
hoverTargets.forEach((target) => {
  const overlay = target.querySelector(".overlay");
  let hoverTimer; // Variável para o temporizador

  // Função para mostrar o overlay
  function showOverlay() {
    overlay.classList.add("show");
  }

  // Função para ocultar o overlay
  function hideOverlay() {
    overlay.classList.remove("show");
    clearTimeout(hoverTimer); // Limpa o temporizador se o mouse sair antes do tempo
  }

  // Quando o mouse entra no alvo
  target.addEventListener("mouseenter", () => {
    // Define um temporizador para mostrar o overlay após 1 segundo (1000ms)
    hoverTimer = setTimeout(showOverlay, 500); // Atraso de 500ms
  });

  // Quando o mouse sai do alvo
  target.addEventListener("mouseleave", hideOverlay);
});
