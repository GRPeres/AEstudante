from sqlalchemy import create_engine
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import insert

class DAO:
    name = "root"
    password = "root"
    host = "localhost"
    database = "aestudante_db"
    
    def __init__(self):
        # Connect to the database schema
        engine = create_engine("mysql+mysqlconnector://" + self.name + ":" + self.password + "@" + self.host + "/" + self.database + "?charset=utf8mb4")

        # ORM mapping with SQLAlchemy
        db = automap_base()
        db.prepare(autoload_with=engine)
        self.produto = db.classes.tb_produtos
        
        self.idt = "id_produtos"
        self.nme = "nome_produtos"
        self.des = "descricao_produtos"
        self.qtd = "quantidade_produtos"
        self.pre = "preco_produtos"

        # Work with ORM sessions
        session_factory = sessionmaker(bind=engine)
        self.ses = session_factory()

    def create(self, obj):
        self.ses.add(obj)
        self.ses.commit()

    def readAll(self):
        return self.ses.query(self.produto).all()

    def readById(self, id):
        return self.ses.query(self.produto).filter(self.produto.id_produtos == id).first()

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

    def __del__(self):
        self.ses.close()
