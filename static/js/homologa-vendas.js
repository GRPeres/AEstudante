// Função que configura listeners para update e delete
function setupListeners(form) {
  const id = form.getAttribute("data-id"); // Obtém o ID do produto
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
        fetch(`/${id}/vendas/update`, {
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
      fetch(`/${id}/vendas/delete`, { method: "POST" }).then((response) => {
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


//Login Functionality

document.addEventListener("DOMContentLoaded", function () {
  // Check if a valid session token exists in localStorage
  const sessionExpiration = localStorage.getItem('sessionExpiration');
  
  // Check if session token is valid (i.e., not expired)
  if (sessionExpiration && new Date().getTime() < sessionExpiration) {
    // Automatically login since session is valid
    autoLogin();
  } else {
    console.log("No valid session found or session has expired");
    // Optionally show login modal or redirect to login page
    document.getElementById("modal").style.display = "block";
  }
});

function autoLogin() {
  console.log("Login successful");
      
  // Set session expiration time (1 hour from now)
  const sessionExpiration = new Date().getTime() + 60 * 60 * 1000; // 1 hour from now
  localStorage.setItem('sessionExpiration', sessionExpiration);

  document.querySelector(".overlap").style.filter = "none";
  document.querySelector(".blocking-box").style.pointerEvents = "none";

  document.getElementById("modal").style.display = "none";
}

document.getElementById("doneButton").addEventListener("click", function () {
  const loginData = new FormData();
  loginData.append("username", document.getElementById("username").value);
  loginData.append("password", document.getElementById("password").value);

  fetch(`/login`, {
    method: "POST",
    body: loginData,
  }).then((response) => {
    if (response.ok) {
      console.log("Login successful");
      
      // Set session expiration time (1 hour from now)
      const sessionExpiration = new Date().getTime() + 60 * 60 * 1000; // 1 hour from now
      localStorage.setItem('sessionExpiration', sessionExpiration);

      document.querySelector(".overlap").style.filter = "none";
      document.querySelector(".blocking-box").style.pointerEvents = "none";
    } else {
      console.error("Error trying to login");
    }
  });
  document.getElementById("modal").style.display = "none";
});



  // Function to fetch the paginated data from Flask
  function fetchPageData(pageNumber) {
    // Make an AJAX request to get the paginated data from Flask
    fetch(`/adm/?page=${pageNumber}`)
      .then(response => response.json())  // Parse JSON response
      .then(data => {
        // Update the table with the new products
        const tableContainer = document.getElementById("tableContainer");
        tableContainer.innerHTML = "";  // Clear the existing table rows

        // Loop through the products and add them to the table
        data.produtos.forEach(produto => {
          const row = document.createElement("div");
          row.classList.add("tableRow");
          row.innerHTML = `
            <form class="updateForm" data-id="${produto.id_vendas}">
                 <strong>Sale ID:</strong> ${ produto.id_vendas }

              <button
                type="button"
                class="homologarBtn buttonBox"
                style=" background-color: {{ 'green' if ${produto.homologar_vendas} == 1 else 'grey' }};">
                {{ 'Homologado' if ${produto.homologar_vendas} == 1 else 'Não Homologado' }}
              </button>
          
              <!-- Delete button -->
              <button
                type="button"
                class="trashBtn iconSize buttonBox"
                style="width: 48px; top: 18px">
                <img src="../static/images/deletarLinha.svg" />
                <!-- Ícone para deletar -->
              </button>
            </form>
          `;
          tableContainer.appendChild(row);
        });

        // Update pagination controls based on current page and total pages
        updatePaginationControls(data.current_page, data.total_pages);
      })
      .catch(error => {
        console.error("Error fetching page data:", error);
      });
  }

  // Function to update pagination controls (Previous / Next buttons)
  function updatePaginationControls(currentPage, totalPages) {
    const prevButton = document.getElementById("prevBtn");
    const nextButton = document.getElementById("nextBtn");

    // Disable previous button if we're on the first page
    prevButton.disabled = currentPage === 1;

    // Disable next button if we're on the last page
    nextButton.disabled = currentPage === totalPages;

    // Set the onclick handlers for the pagination buttons
    prevButton.onclick = () => fetchPageData(currentPage - 1);
    nextButton.onclick = () => fetchPageData(currentPage + 1);
  }

  // Initialize the page by fetching data for the first page
  document.addEventListener("DOMContentLoaded", () => {
    fetchPageData(1);  // Fetch the first page by default
  });
  document.addEventListener("DOMContentLoaded", function() {
    // Get all homologar buttons
    const homologarButtons = document.querySelectorAll('.homologarBtn');
  
    // Add click event listener for each button
    homologarButtons.forEach(function(button) {
      button.addEventListener('click', function() {
        const form = button.closest('form');
        const vendaId = form.getAttribute('data-id'); // Sale ID
        const homologarValue = button.textContent === 'Homologado' ? 1 : 0; // Determine current value (1 or 0)
  
        // Toggle the value of homologar_vendas
        const newHomologarValue = homologarValue === 1 ? 0 : 1;
        
        // Update the button's text and background color based on the new value
        if (newHomologarValue === 1) {
          button.textContent = 'Homologado';
          button.style.backgroundColor = 'green';
        } else {
          button.textContent = 'Não Homologado';
          button.style.backgroundColor = 'grey';
        }
  
        const formData = new FormData(form);
        formData.append('homologar_vendas', newHomologarValue); // Add homologar_vendas field to form data

        // Send the updated data to the Flask server
        fetch(`/${vendaId}/vendas/update`, {
          method: 'POST',
          body: formData
        })
        .then(response => {
          if (response.ok) {
            return response.json();
          } else {
            return Promise.reject('Failed to update');
          }
        })
        .then(data => {
          console.log('Venda updated successfully:', data);
        })
        .catch(error => {
          console.error('Error updating venda:', error);
        });
      });
    });
  });
  