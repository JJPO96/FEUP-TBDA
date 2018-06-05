db.createCollection("uses",{autoIndexId : true})
db.createCollection("activities",{autoIndexId : true})
db.createCollection("facilities",{autoIndexId : true})
db.createCollection("roomtypes",{autoIndexId : true})
db.createCollection("municipalities",{autoIndexId : true})
db.createCollection("districts",{autoIndexId : true})
db.createCollection("regions",{autoIndexId : true})

//facilities definition
{
    id: {type: Number, required: true, unique: true},
    nome: {type: String, required: true},
    lotacao: {type: Number, required: true},
    tipo: {type: String,  required: true},
    morada: {type: String, required: true},
    concelho: [
        id: {type: Number, required: true, unique: true},
        designacao: {type: String, required: true},
        distrito: [
            id: {type: Number, required: true, unique: true},
            designacao: {type: String, required: true},
        ],
        regiao: [
            id: {type: Number, unique: true},
            designacao: {type: String},
            NUT: {type: String}
        ]
    ]
}

//municipalities definition
{
    id: {type: Number, required: true, unique: true},
    designacao: {type: String, required: true},
    distrito: [
        id: {type: Number, required: true, unique: true},
        designacao: {type: String, required: true},
    ],
    regiao: [
        id: {type: Number, unique: true},
        designacao: {type: String},
        NUT: {type: String}
    ]
)

//districts definition
{
    id: {type: Number, required: true, unique: true},
    designacao: {type: String, required: true}
}

//regions definition
{
    id: {type: Number, unique: true},
    designacao: {type: String},
    NUT: {type: String}
}

