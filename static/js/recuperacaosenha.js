const enviarBtn = document.getElementById("enviarBtn");
const voltarBtn = document.getElementById("voltarBtn");
const enviarSection = document.querySelector(".recuperacao-senha-enviar");
const voltarSection = document.querySelector(".recuperacao-senha-voltar");

// Função para mostrar a seção de "Pedido Enviado" e esconder o formulário
enviarBtn.addEventListener("click", () => {
  enviarSection.style.display = "none";
  voltarSection.style.display = "flex";
});

// Função para voltar para o formulário de recuperação de senha
voltarBtn.addEventListener("click", () => {
  enviarSection.style.display = "flex";
  voltarSection.style.display = "none";
});
