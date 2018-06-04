mongoimport --db tbda --collection concelhos --file concelhosR.json --mode upsert 
mongoimport --db tbda --collection distritos --file distritosR.json --mode upsert
mongoimport --db tbda --collection recintos --file recintosR.json --mode upsert
mongoimport --db tbda --collection usos --file usosR.json --mode upsert