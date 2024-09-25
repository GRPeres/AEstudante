from flask import Flask, request, jsonify, render_template, url_for, redirect
from flask_login import current_user, LoginManager, login_user, logout_user, login_required, UserMixin
from dao_bdd import DAO

app = Flask(__name__)
app.secret_key = 'test1'

#Rota principal da pagina de controle de estoque
@app.route('/adm/', methods=['GET'])
def index(): 
    dao = DAO()
    produtos = dao.readAll()
    return render_template('adm.html', produtos=produtos)

#rota auxiliar que atualiza dados na tabela produto
@app.route('/<int:id>/update', methods=['POST'])
def update_produto(id):
    dao = DAO()
    
    nome_produtos = request.form['nome_produtos']
    descricao_produtos = request.form['descricao_produtos']
    quantidade_produtos = request.form['quantidade_produtos']
    
    produto = dao.readById(id)
    if produto:
        produto.nome_produtos = nome_produtos
        produto.descricao_produtos = descricao_produtos
        produto.quantidade_produtos = quantidade_produtos
        
        dao.update(produto)
        return ('', 204)
    return ('Product not found', 404)

#rota auxiliar que cria um  novo produto na tabela
@app.route('/add',  methods=['POST'])
def add_product():
    dao = DAO()

    novo_produto = dao.produto(
        nome_produtos= 'filler',
        descricao_produtos= 'filler',
        quantidade_produtos= '0'
    )

    try:
        dao.create(novo_produto)
        return jsonify({
            'message': 'Product added successfully',
            'id': novo_produto.id_produtos
        }), 201
    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({'error': str(e)}), 400
    
#rota auxiliar que deleta um produto da tabela
@app.route('/<int:id>/delete', methods=['POST'])
def delete_produto(id):
    dao = DAO()
    produto = dao.readById(id)
    if produto:
        dao.delete(produto)
        return ('', 204)
    return ('Product not found', 404)


app.run(debug=True)
