//a
db.getCollection('recintos').find(
    {
        "tipo":
        {
            $regex : "touros"
        },
        "atividades": "teatro"
    },
    {
        "nome": 1,
        "tipo": 1, 
        "atividades": 1
    }
)

//b.
db.getCollection('recintos').aggregate(
    {
        $match: 
        {
            "tipo": 
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
db.concelhos.count() - db.getCollection('recintos').aggregate(
    {
        $match: 
        {
            "atividades": 
            {
                $in: ["cinema"]
            }
        }
    },
    {
        $group:
        { 
            _id: "$concelho.designacao",
            quantidade:
            {
                $sum: 1
            }
        }
    }
).toArray().length

//d.


//e.


//f.