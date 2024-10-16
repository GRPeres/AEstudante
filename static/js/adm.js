
      // Função que configura listeners para update e delete
      function setupListeners(form) {
        const id = form.getAttribute("data-id"); // Obtém o ID do produto
        console.log(id);
        const debounceTime = 1000; // Tempo de debounce em milissegundos
        let debounceTimer;

        // Adiciona listeners para os campos de entrada do formulário
        form.querySelectorAll("input").forEach((input) => {
          input.addEventListener("input", function () {
            // Limpa o timer anterior
            clearTimeout(debounceTimer);

            // Define um novo timer
            debounceTimer = setTimeout(() => {
              const formData = new FormData(form); // Captura os dados do formulário
              fetch(`/${id}/update`, {
                method: "POST",
                body: formData,
              }).then((response) => {
                if (response.ok) {
                  console.log("Product updated successfully");
                } else {
                  console.error("Error updating product");
                }
              });
            }, debounceTime);
          });
        });

        // Adiciona listener para o botão de deletar
        form.querySelectorAll(".trashBtn").forEach((button) => {
          button.addEventListener("click", function () {
            fetch(`/${id}/delete`, { method: "POST" }).then((response) => {
              if (response.ok) {
                this.closest(".tableRow").remove(); // Remove a linha da tabela
              } else {
                console.error("Error deleting product");
              }
            });
          });
        });
      }

      // Insere listeners nas linhas obtidas do banco de dados durante o startup da aplicação
      document.querySelectorAll(".updateForm").forEach((form) => {
        setupListeners(form);
      });

      // Lógica da criação de novas linhas na tabela
      document
        .getElementById("addRowBtn")
        .addEventListener("click", function () {
          // Definição do HTML para uma nova linha
          const newRow = document.createElement("div");
          newRow.classList.add("tableRow");
          newRow.innerHTML = `
      <form class="updateForm" data-id="null">
          <input class="divWrapper defaultBox" style="width: 20%;" name="nome_produtos" placeholder="Nome" />
          <input class="divWrapper defaultBox" style="width: 50.4%;" name="descricao_produtos" placeholder="Descrição" />
          <input class="divWrapper step='0.01' defaultBox" style="width: 4%;" name="preco_produtos" placeholder="Preço" />
          <input class="divWrapper defaultBox" style="width: 2%;" name="quantidade_produtos" placeholder="Qtd" />
          <button  type="button" class="trashBtn iconSize buttonBox" style="width: 48px; top: 18px;">
              <img src="../static/images/eos-icons--content-deleted.svg" />
          </button>
      </form>
    `;

          // Definição da lista objeto representando os elementos de uma linha
          const formElement = newRow.querySelector(".updateForm");
          const formData = new FormData(formElement);

          // Invoca o método para criar a linha e recebe de volta o ID da linha no banco de dados
          fetch("/add", {
            method: "POST",
            body: formData,
          })
            .then((response) => {
              if (!response.ok) {
                throw new Error("Network response was not ok");
              }
              return response.json();
            })
            .then((data) => {
              // Atualiza o elemento HTML com o ID recebido e configura os listeners para que essa linha possa ser editável
              formElement.setAttribute("data-id", data.id);
              setupListeners(formElement);
              console.log(
                "New product added successfully, ID:",
                formElement.getAttribute("data-id")
              );
              document.getElementById("tableContainer").appendChild(newRow); // Adiciona a nova linha à tabela
            })
            .catch((error) => {
              console.error("Error adding new product:", error);
            });
        });

      // Listener para o botão de filtro
      document
        .getElementById("filterBtn")
        .addEventListener("click", function () {
          var T = document.getElementById("floatingBox");
          T.style.display = "block"; // Exibe a caixa de filtro

          document
            .getElementById("acceptBtn")
            .addEventListener("click", function () {
              // Coleta critérios de filtro dos campos de entrada
              const filterData = new FormData();
              const inputFlt = document.getElementById("inputFilter").value; // Valor do input de filtro
              const dropdownValue = document.querySelector(".dropdown").value; // Valor selecionado no dropdown

              // Anexa critérios de filtro ao FormData
              switch (dropdownValue) {
                case "option1":
                  console.log("Selected Nome"); // Log para opção de nome
                  filterData.append("nome_produtos", inputFlt);
                  break;
                case "option2":
                  console.log("Selected Desc"); // Log para opção de descrição
                  filterData.append("descricao_produtos", inputFlt);
                  break;
                case "option3":
                  console.log("Selected Preço"); // Log para opção de quantidade
                  filterData.append("preco_produtos", inputFlt);
                  break;
                case "option4":
                  console.log("Selected QTD"); // Log para opção de quantidade
                  filterData.append("quantidade_produtos", inputFlt);
                  break;
                default:
                  console.log("No valid option selected");
              }

              // Envia a solicitação de filtro para o servidor
              fetch("/filter", {
                method: "POST",
                body: filterData,
              })
                .then((response) => response.json())
                .then((data) => {
                  // Limpa as linhas existentes
                  const tableContainer =
                    document.getElementById("tableContainer");
                  tableContainer.innerHTML = "";

                  // Adiciona os produtos filtrados de volta à tabela
                  data.produtos.forEach((produto) => {
                    const newRow = document.createElement("div");
                    newRow.classList.add("tableRow");
                    newRow.innerHTML = `
        <form class="updateForm" data-id="${produto.id_produtos}">
          <input class="divWrapper defaultBox" style="width: 20%;" name="nome_produtos" value="${produto.nome_produtos}" placeholder="Nome" />
          <input class="divWrapper defaultBox" style="width: 50.4%;" name="descricao_produtos" value="${produto.descricao_produtos}" placeholder="Descrição" />
          <input class="divWrapper defaultBox" step='0.01' style="width: 4%" name="preco_produtos" value="${produto.preco_produtos}" placeholder="Preço" />
          <input class="divWrapper defaultBox" style="width: 2%;" name="quantidade_produtos" value="${produto.quantidade_produtos}" placeholder="Qtd" />
          <button  type="button" class="trashBtn iconSize buttonBox"  style="width: 48px; top: 18px;">
            <img src="../static/images/eos-icons--content-deleted.svg" />
          </button>
        </form>
      `;
                    tableContainer.appendChild(newRow);
                    setupListeners(newRow.querySelector(".updateForm")); // Configura listeners para novas linhas
                    T.style.display = "none"; // Oculta a caixa de filtro após a aplicação
                  });
                })
                .catch((error) => {
                  console.error("Error filtering products:", error);
                });
            });
        });

      // Listener para o botão de home
      document.getElementById("homeBtn").addEventListener("click", function () {
        console.error("you pressed the button", error); // Log de erro ao pressionar o botão
      });

      document.getElementById("doneButton").addEventListener("click", function() {

        const loginData = new FormData();
        loginData.append("username",document.getElementById("username").value);
        loginData.append("password",document.getElementById("password").value);

        fetch(`/login`, {
                method: "POST",
                body: loginData,
              }).then((response) => {
                if (response.ok) {
                  console.log("Login successful");
                  document.querySelector(".overlap").style.filter = "none";
                } else {
                  console.error("Error trying to login");
                }
              });
              document.getElementById("modal").style.display = "none";  
      });