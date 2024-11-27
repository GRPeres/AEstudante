from flask import Flask, request, jsonify, render_template, url_for, redirect, session
from flask_login import current_user, LoginManager, login_user, logout_user, login_required, UserMixin
from dao_bdd import *
from decimal import *
import qrcode
import os

app = Flask(__name__)
app.secret_key = 'test1'


# Constante para controlar o número de itens por página
ITEMS_PER_PAGE = 20# Exemplo: 10 itens por página


# Rota principal da página inicial
@app.route('/', methods=['GET'])
def index(): 

    dao = DAO()
    promocoes = dao.readAll()  # Busca todos os produtos no banco de dados
    
    # Obtém o número da página da URL (parâmetro 'page'), se não fornecido, assume a página 1
    page = int(request.args.get('page', 1))
    
    # Calcula os índices de início e fim com base no número da página
    start = (page - 1) * ITEMS_PER_PAGE
    end = start + ITEMS_PER_PAGE
    promocoes_paginadas = promocoes[start:end]
    
    # Calcula o número total de páginas
    total_pages = (len(promocoes) + ITEMS_PER_PAGE - 1) // ITEMS_PER_PAGE  # Arredonda para cima
    
    # Passa os dados para o template
    return render_template('paginainicial.html', 
                           promocoes=promocoes_paginadas, 
                           novidades=promocoes_paginadas,
                           current_page=page, 
                           total_pages=total_pages)

@app.route('/adm/', methods=['GET'])
def adm():
   
    # Constante para controlar o número de itens por página
    ITEMS_PER_PAGE_ADM = 11  # Exemplo: 10 itens por página

    dao = DAO()
    promocoes = dao.readAll()  # Busca todos os produtos no banco de dados
    
    # Obtém o número da página da URL (parâmetro 'page'), se não fornecido, assume a página 1
    page = int(request.args.get('page', 1))
    
    # Calcula os índices de início e fim com base no número da página
    start = (page - 1) * ITEMS_PER_PAGE_ADM
    end = start + ITEMS_PER_PAGE_ADM
    promocoes_paginadas = promocoes[start:end]
    
    # Calcula o número total de páginas
    total_pages = (len(promocoes) + ITEMS_PER_PAGE_ADM - 1) // ITEMS_PER_PAGE_ADM  # Arredonda para cima
    
    # Passa os dados para o template
    return render_template('adm.html', 
                           produtos=promocoes_paginadas, 
                           current_page=page, 
                           total_pages=total_pages)



# Rota auxiliar que atualiza dados na tabela produto
@app.route('/<int:id>/update', methods=['POST'])
def update_produto(id):
    dao = DAO()
    
    # Captura os dados do produto a partir do formulário
    nome_produtos = request.form['nome_produtos']
    descricao_produtos = request.form['descricao_produtos']
    quantidade_produtos = request.form['quantidade_produtos']
    preco_produtos = request.form['preco_produtos']
    imagem_produtos = request.form['imagem_produtos']
    categoria_produtos = request.form['categoria_produtos']
    
    produto = dao.readById(id)  # Busca o produto pelo ID
    if produto:
        # Atualiza os atributos do produto
        produto.nome_produtos = nome_produtos
        produto.descricao_produtos = descricao_produtos
        produto.quantidade_produtos = quantidade_produtos
        produto.preco_produtos = preco_produtos
        produto.imagem_produtos = imagem_produtos
        produto.categoria_produtos = categoria_produtos
        
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
        preco_produtos=Decimal(0),
        quantidade_produtos='0',
        imagem_produtos='Insira URL Aqui!',
        categoria_produtos='filler'
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
    preco_produtos = request.form.get('preco_produtos')

    # Aplica filtros com base nos critérios fornecidos
    if nome_produtos:
        produtos = dao.readByNome(nome_produtos)  # Filtra por nome do produto
    elif descricao_produtos:
        produtos = dao.readBy('descricao_produtos', "ilike", descricao_produtos)  # Filtra por descrição do produto
    elif preco_produtos:
        try:
            preco = Decimal(preco_produtos)  # Tenta converter a quantidade para inteiro
            produtos = dao.readBy('preco_produtos', "==", preco)  # Filtra por quantidade do produto
        except ValueError:
            return jsonify({'error': 'Preço must be a number'}), 400  # Retorna erro se a quantidade não for um número
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
                'preco_produtos': produto.preco_produtos,
                'imagem_produtos': produto.imagem_produtos,
                'categoria_produtos': produto.categoria_produtos,
            }
            for produto in produtos
        ]
    }

    return jsonify(response_data)  # Retorna os produtos filtrados como JSON

@app.route('/login', methods=['POST'])
def login():
    dao = DAO()
    username = request.form['username']
    password = request.form['password']
    
    if dao.loginDB(username,password):
        return redirect(url_for('adm'))  # Redirect to the admin page
    else:
        return jsonify({'error': 'Invalid credentials'}), 401  # Unauthorized
    

# Rota principal da página de controle de estoque
@app.route('/items/<int:id>', methods=['GET'])
def items(id): 
    dao = DAO()
    produto = dao.readById(id)
    if produto:    
        return render_template('display-produto.html', produto=produto)
    else:
        return render_template('display-produto.html', produto=dao.readById(1))

@app.route('/adicionar_carrinho/<int:produto_id>', methods=['POST'])
def adicionar_carrinho(produto_id):
    quantidade = int(request.form.get('quantidade', 1))  # Recebe a quantidade do formulário ou usa 1 como padrão

    # Inicializa o carrinho como um dicionário se ainda não existir
    if 'carrinho' not in session:
        session['carrinho'] = {}

    if str(produto_id) in session['carrinho']:
        session['carrinho'][str(produto_id)] += quantidade
    else:
        session['carrinho'][str(produto_id)] = quantidade

    session.modified = True

    return redirect(request.referrer)

@app.route('/ver_carrinho')
def ver_carrinho():
    # Recupera os itens do carrinho da sessão e passa para o template
    carrinho = session.get('carrinho', {})
    produto_ids = list(carrinho.keys())

    dao = DAO()
    lista_produtos = []
    for i in produto_ids:
        produto = dao.readById(i)
        lista_produtos.append(produto)
    return render_template('cart.html', carrinho=carrinho, produtos=lista_produtos)

@app.route('/gerar_mensagem')
def gerar_mensagem():
    carrinho = session.get('carrinho', {})
    dao = DAO()

    mensagem = "Olá! Gostaria de comprar os seguintes produtos:\n\n"
    for produto_id, quantidade in carrinho.items():
        produto = dao.readById(produto_id)
        mensagem += f"- {produto.nome_produtos}: {quantidade} unidades\n"

    numero_whatsapp = "5551999999999"
    mensagem_codificada = mensagem.replace(" ", "%20")

    url_whatsapp = f"https://wa.me/{numero_whatsapp}?text={mensagem_codificada}"
    qr = qrcode.make(url_whatsapp)

    # Definir o caminho da pasta 'imagens' dentro de 'static' e salvar a imagem
    caminho_pasta_imagens = os.path.join('static', 'images')
    caminho_qr = os.path.join(caminho_pasta_imagens, 'qrcode_whatsapp.png')
    qr.save(caminho_qr)

    return render_template('whatsapp.html')

@app.route('/remover_do_carrinho/<int:produto_id>', methods=['POST'])
def remover_do_carrinho(produto_id):
    carrinho = session.get('carrinho', {})
    try:
        del carrinho[str(produto_id)]
        print(carrinho)
        session.modified = True
    except:
        pass
    return redirect(url_for('ver_carrinho'))

@app.route('/search', methods=['GET'])
def search():
    search_term = request.args.get('search_term', '')  # Get the search term from the query string
    dao = DAO()

    # Assuming your DAO methods can search by name or description
    add_product = []

    if search_term:
        # Filter products based on search term (this can be adjusted based on your database schema)
        promocoes = dao.readByNome('nome_produtos')  # Filter by name
        if not promocoes:
            promocoes = dao.readBy('descricao_produtos', 'ilike', search_term)  # Try filtering by description
    else:
        promocoes = dao.readAll()  # If no search term, return all products

    # Obtém o número da página da URL (parâmetro 'page'), se não fornecido, assume a página 1
    page = int(request.args.get('page', 1))
    
    # Calcula os índices de início e fim com base no número da página
    start = (page - 1) * ITEMS_PER_PAGE
    end = start + ITEMS_PER_PAGE
    promocoes_paginadas = promocoes[start:end]
    
    # Calcula o número total de páginas
    total_pages = (len(promocoes) + ITEMS_PER_PAGE - 1) // ITEMS_PER_PAGE  # Arredonda para cima
    
    # Passa os dados para o template
    return render_template('paginainicial.html', 
                           promocoes=promocoes_paginadas, 
                           novidades=promocoes_paginadas,
                           current_page=page, 
                           total_pages=total_pages)
'''
@app.route('/remover_itens_banco')
def remover_itens_banco():
    carrinho = session.get('carrinho', {})
    dao = DAO()
    lista_produtos = []
    # Busca cada produto por id e remove do banco de dados a quantidade vendida ate 0, alem de remover do carrihno
    for produto_id, quantidade in carrinho.items():
        produto = dao.readById(produto_id)
        lista_produtos.append(produto)
        if produto.quantidade_produtos > quantidade:
            produto.quantidade_produtos -= quantidade
        else:
            produto.quantidade_produtos = 0
        dao.update(produto)
    carrinho.clear()
    session.modified = True

    return redirect(url_for('ver_carrinho'))
'''
app.run(debug=True)
#app.run('0.0.0.0') #so assim para ver imagens
