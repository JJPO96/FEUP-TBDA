from pymongo import MongoClient

if __name__ == "__main__":
    client = MongoClient()
    db = client.tbda
    db.distritos.drop()
    db.concelhos.drop()
    db.recintos.drop()
    db.regioes.drop()

    # collections não necessárias
    db.usos.drop()
    db.tipos.drop()
    db.atividades.drop()