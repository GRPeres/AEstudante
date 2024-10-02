from flask import Flask, request, jsonify, render_template, url_for, redirect
from flask_login import current_user, LoginManager, login_user, logout_user, login_required, UserMixin
from dao_bdd import DAO

app = Flask(__name__)
app.secret_key = 'test1'

# Rota principal da página inicial
@app.route('/', methods=['GET'])
def index(): 
    return render_template('index.html')

# Rota principal da página de controle de estoque
@app.route('/adm/', methods=['GET'])
def adm(): 
    dao = DAO()
    produtos = dao.readAll()  # Lê todos os produtos do banco de dados
    return render_template('adm.html', produtos=produtos)

# Rota auxiliar que atualiza dados na tabela produto
@app.route('/<int:id>/update', methods=['POST'])
def update_produto(id):
    dao = DAO()
    
    # Captura os dados do produto a partir do formulário
    nome_produtos = request.form['nome_produtos']
    descricao_produtos = request.form['descricao_produtos']
    quantidade_produtos = request.form['quantidade_produtos']
    
    produto = dao.readById(id)  # Busca o produto pelo ID
    if produto:
        # Atualiza os atributos do produto
        produto.nome_produtos = nome_produtos
        produto.descricao_produtos = descricao_produtos
        produto.quantidade_produtos = quantidade_produtos
        
        dao.update(produto)  # Atualiza o produto no banco de dados
        return ('', 204)  # Retorna resposta 204 (No Content)
    return ('Product not found', 404)  # Retorna erro 404 se o produto não for encontrado

# Rota auxiliar que cria um novo produto na tabela
@app.route('/add',  methods=['POST'])
def add_product():
    dao = DAO()

    # Cria um novo produto com valores padrão
    novo_produto = dao.produto(
        nome_produtos='filler',
        descricao_produtos='filler',
        quantidade_produtos='0'
    )

    try:
        dao.create(novo_produto)  # Adiciona o novo produto ao banco de dados
        return jsonify({
            'message': 'Product added successfully',
            'id': novo_produto.id_produtos  # Retorna ID do novo produto
        }), 201  # Retorna resposta 201 (Created)
    except Exception as e:
        print(f"Error occurred: {e}")  # Log de erro
        return jsonify({'error': str(e)}), 400  # Retorna erro 400 (Bad Request)
    
# Rota auxiliar que deleta um produto da tabela
@app.route('/<int:id>/delete', methods=['POST'])
def delete_produto(id):
    dao = DAO()
    produto = dao.readById(id)  # Busca o produto pelo ID
    if produto:
        dao.delete(produto)  # Deleta o produto do banco de dados
        return ('', 204)  # Retorna resposta 204 (No Content)
    return ('Product not found', 404)  # Retorna erro 404 se o produto não for encontrado

# Rota para filtrar produtos com base nos critérios fornecidos
@app.route('/filter', methods=['POST'])
def filter_products():  
    dao = DAO()
    produtos = []  # Inicializa a lista como vazia

    # Coleta critérios de filtro do formulário
    nome_produtos = request.form.get('nome_produtos')
    descricao_produtos = request.form.get('descricao_produtos')
    quantidade_produtos = request.form.get('quantidade_produtos')

    # Aplica filtros com base nos critérios fornecidos
    if nome_produtos:
        produtos = dao.readByNome(nome_produtos)  # Filtra por nome do produto
    elif descricao_produtos:
        produtos = dao.readBy('descricao_produtos', "ilike", descricao_produtos)  # Filtra por descrição do produto
    elif quantidade_produtos:
        try:
            quantidade = int(quantidade_produtos)  # Tenta converter a quantidade para inteiro
            produtos = dao.readBy('quantidade_produtos', "==", quantidade)  # Filtra por quantidade do produto
        except ValueError:
            return jsonify({'error': 'Quantidade must be a number'}), 400  # Retorna erro se a quantidade não for um número
    else:
        # Se nenhum filtro for aplicado, retorna todos os produtos
        produtos = dao.readAll()

    # Prepara os dados da resposta
    response_data = {
        'produtos': [
            {
                'id_produtos': produto.id_produtos,
                'nome_produtos': produto.nome_produtos,
                'descricao_produtos': produto.descricao_produtos,
                'quantidade_produtos': produto.quantidade_produtos,
            }
            for produto in produtos
        ]
    }

    return jsonify(response_data)  # Retorna os produtos filtrados como JSON

# Inicia a aplicação Flask em modo de debug
app.run(debug=True)
