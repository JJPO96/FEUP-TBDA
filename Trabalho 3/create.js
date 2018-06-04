db.createCollection("uses",{autoIndexId : true})
db.createCollection("activities",{autoIndexId : true})
db.createCollection("facilities",{autoIndexId : true})
db.createCollection("roomtypes",{autoIndexId : true})
db.createCollection("municipalities",{autoIndexId : true})
db.createCollection("districts",{autoIndexId : true})
db.createCollection("regions",{autoIndexId : true})

//uses definition
{
    id: {type: Number, required: true, unique: true},
    ref: {type: Number, required: true, unique: true}
}

//activities definition
{
    ref: {type: Number, required: true, unique: true},
    activity: {type: String, required: true}
}


//facilities definition
{
    id: {type: Number, required: true, unique: true},
    name: {type: String, required: true},
    capacity: {type: Number, required: true},
    roomtype: [
        // referenciar? sure, mas como?
    ],
    address: {type: String, required: true},
    municipality: [
       // referenciar? sure, mas como?
    ]
}

//roomtypes definition
{
    roomtype: {type: Number, required: true, unique: true},
    description:  {type: String, required: true}
}

//municipalities definition
{
    cod: {type: Number, required: true, unique: true},
    designation: {type: String, required: true},
    district: [
        // referenciar? sure, mas como?
    ],
    region: [
        // referenciar? sure, mas como?
    ]
)

//districts definition
{
    cod: {type: Number, required: true, unique: true},
    designation: {type: String, required: true},
    region: [
        cod // referenciar? sure, mas como?
    ]
}

//regions definition
{
    cod: {type: Number, required: false, unique: true},
    designation: {type: String, required: false},
    NUT: [
        "Continente",
        "Açores",
        "Madeira"
    ] //não sei como representar isto enum?
}

