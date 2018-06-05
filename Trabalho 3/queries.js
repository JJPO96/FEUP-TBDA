//a - falta as cenas relativas a atividades
db.getCollection('recintos').find(
    {
        "tipo.descricao":
        {
            $regex : "touros"
        }
    },
    {
        "id": 1,
        "nome": 1,
        "tipo.descricao": 1, 
        _id: 0
    }
)

//b
db.getCollection('recintos').aggregate(
    {
        $match: 
        {
            "tipo.descricao": 
            {
                $regex : "touros"
            }
        }
    },
    {
        $group:
         { 
             _id: "$concelho.regiao.designacao",
              quantidade:
              {
                  $sum: 1
              }
        }
    }
)
      