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
db.getCollection('recintos').aggregate([
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
])
     
//c.
db.concelhos.count() - db.getCollection('recintos').aggregate([
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
]).toArray().length

//d.
db.getCollection('recintos').aggregate([   
    {
        $unwind: "$atividades" 
    },
    {
        $group:
        { 
            _id: { concelho: "$concelho.designacao", atividade: "$atividades"},
            quantidade:
            {
                $sum: 1
            }
            
        }
    },
    {
        $group:
        { 
            _id: "$_id.atividade",
            quantidade: { $max: "$quantidade"}         
        }
    }
])

//e.
db.getCollection('concelhos').aggregate([
    {
        $lookup:
        {
            from: 'recintos',
            localField: '_id',
            foreignField: 'concelho._id',
            as: 'recintos'
        }
    }, {
        $group:
        {
            _id: {_id:"$distrito._id", designacao:"$distrito.designacao"},
            concelhos: { $push: { nome: "$designacao", temRecintos: {$gt: [{ $size: "$recintos" },0]}}}
        }, 
    }, {
        $match:
        {
            "concelhos" : {"$not":{"$elemMatch":{"temRecintos":false}}}
        }
    }
])

//f.
db.getCollection('concelhos').find
(
	{
		"regiao.designacao": "Norte"
	}
).count()