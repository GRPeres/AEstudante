// Obtém o elemento alvo e o overlay
const hoverTarget = document.querySelector(".hover-target");
const overlay = document.querySelector(".overlay");

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
hoverTarget.addEventListener("mouseenter", () => {
  // Define um temporizador para mostrar o overlay após 1 segundo (1000ms)
  hoverTimer = setTimeout(showOverlay, 50);
});

// Quando o mouse sai do alvo
hoverTarget.addEventListener("mouseleave", hideOverlay);
