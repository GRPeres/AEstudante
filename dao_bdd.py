from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, Double
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy.orm import backref

Base = declarative_base()

# Define the Produto class
class Produto(Base):
    __tablename__ = 'tb_produtos'

    id_produtos = Column(Integer, primary_key=True)
    nome_produtos = Column(String(50), unique=True, nullable=False)
    preco_produtos = Column(Double, nullable=False)
    descricao_produtos = Column(String(250), nullable=False)
    categoria_produtos = Column(String(50), nullable=False)
    quantidade_produtos = Column(Integer, nullable=False)
    imagem_produtos = Column(String(250), nullable=False)

    # Define the many-to-many relationship with Venda (via the ProdutoVenda association table)
    vendas = relationship("ProdutoVenda", back_populates="produto")

# Define the Venda class
class Venda(Base):
    __tablename__ = 'tb_vendas'

    id_vendas = Column(Integer, primary_key=True)
    homologar_vendas = Column(Integer, nullable=False)

    # Define the many-to-many relationship with Produto (via the ProdutoVenda association table)
    produtos = relationship("ProdutoVenda", back_populates="venda")

# Define the ProdutoVenda (association) class
class ProdutoVenda(Base):
    __tablename__ = 'tb_produtos_has_tb_vendas'

    # Composite primary key
    tb_produtos_id_produtos = Column(Integer, ForeignKey('tb_produtos.id_produtos', ondelete='CASCADE'), primary_key=True)
    tb_vendas_id_vendas = Column(Integer, ForeignKey('tb_vendas.id_vendas', ondelete='CASCADE'), primary_key=True)

    # Relationships for both sides
    produto = relationship(Produto, back_populates="vendas")
    venda = relationship(Venda, back_populates="produtos")

# DAO class to handle CRUD operations and many-to-many relationship
class DAO:
    name = "root"
    password = "quemleumecomeu"
    host = "localhost"
    database = "aestudante_db"
    
    def __init__(self):
        # Connect to the database schema
        engine = create_engine(f"mysql+mysqlconnector://{self.name}:{self.password}@{self.host}/{self.database}?charset=utf8mb4")

        # ORM mapping with SQLAlchemy
        Base.metadata.create_all(engine)

        # Tables
        self.produto = Produto
        self.venda = Venda
        self.produto_venda = ProdutoVenda

        # Work with ORM sessions
        session_factory = sessionmaker(bind=engine)
        self.ses = session_factory()

    # Existing CRUD operations for Produto (tb_produtos)
    def create(self, obj):
        self.ses.add(obj)
        self.ses.commit()

    def readAll(self):
        return self.ses.query(self.produto).all()
    
    def readAllVendas(self):
        return self.ses.query(self.venda).all()

    def readById(self, id):
        return self.ses.query(self.produto).filter(self.produto.id_produtos == id).first()

    def readByIdVenda(self, id):
        return self.ses.query(self.venda).filter(self.venda.id_vendas == id).first()

    def readByNome(self, nome):
        return self.ses.query(self.produto).filter(self.produto.nome_produtos.ilike(f'%{nome}%')).all()

    def readByNomeFirstMatch(self, nome): 
        return self.ses.query(self.produto).filter(self.produto.nome_produtos.ilike(f'%{nome}%')).first()

    def readBy(self, campo, oper, valor):
        if oper == "==":
            query = getattr(self.produto, campo) == valor
        elif oper == "ilike":
            query = getattr(self.produto, campo).ilike(f'%{valor}%')
        else:
            query = eval(f"self.produto.{campo} {oper} valor")

        return self.ses.query(self.produto).filter(query).all()

    def update(self, obj):
        self.ses.merge(obj)
        self.ses.commit()

    def delete(self, obj):
        self.ses.delete(obj)
        self.ses.commit()

    def getSes(self):
        return self.ses

    def loginDB(self, user, password):
        if self.name == user and self.password == password:
            return True
        else:
            return False

    def __del__(self):
        self.ses.close()

    # Methods for handling many-to-many relationships

    # Add a product to a sale
    def addProductToSale(self, produto_id, venda_id):
        produto = self.ses.query(self.produto).get(produto_id)
        venda = self.ses.query(self.venda).get(venda_id)

        if produto and venda:
            produtoVenda = self.produto_venda(
                tb_produtos_id_produtos=produto.id_produtos,
                tb_vendas_id_vendas=venda.id_vendas,
            )
            self.ses.add(produtoVenda)
            self.ses.commit()

    # Get all products for a sale
    def getProductsForSale(self, venda_id):
        venda = self.ses.query(self.venda).get(venda_id)
        if venda:
            return [pv.produto for pv in venda.produtos]
        return []

    # Get all sales for a product
    def getSalesForProduct(self, produto_id):
        produto = self.ses.query(self.produto).get(produto_id)
        if produto:
            return [pv.venda for pv in produto.vendas]
        return []

    def createSale(self, obj):
        self.ses.add(obj)
        self.ses.commit()
        self.ses.refresh(obj)
        return obj.id_vendas