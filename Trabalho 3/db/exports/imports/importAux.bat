python mongo_clean.py
mongoimport --db tbda --collection concelhos --file concelhosR.json --mode upsert 
mongoimport --db tbda --collection distritos --file distritosR.json --mode upsert
mongoimport --db tbda --collection recintos --file recintosR.json --mode upsert
mongoimport --db tbda --collection regioes --file regioesR.json --mode upsert