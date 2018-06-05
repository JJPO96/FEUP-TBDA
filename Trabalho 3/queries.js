//a - é suposto mostrar as atividades todas, certo?
db.getCollection('recintos').find(
    {
        "tipo.descricao":
        {
            $regex : "touros"
        },
        "atividades": "teatro"
    },
    {
        "id": 1,
        "nome": 1,
        "tipo.descricao": 1, 
        "atividades": 1,
        _id: 0
    }
)

//b.
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
     
//c.

//d.
//e.
