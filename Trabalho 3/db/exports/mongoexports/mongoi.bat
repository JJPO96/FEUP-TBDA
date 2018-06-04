python .\change_refs.py
mongoimport --db tbda --collection atividades --file atividades.json --mode upsert --upsertFields ref
mongoimport --db tbda --collection concelhos --file concelhos.json --mode upsert --upsertFields cod
mongoimport --db tbda --collection distritos --file distritos.json --mode upsert --upsertFields cod
mongoimport --db tbda --collection recintos --file recintos.json --mode upsert --upsertFields id
mongoimport --db tbda --collection regioes --file regioes.json --mode upsert --upsertFields cod
mongoimport --db tbda --collection tipos --file tipos.json --mode upsert --upsertFields tipo
mongoimport --db tbda --collection usos --file usos.json --mode upsert --upsertFields id,ref
cd imports
call importAux.bat
cd ..