python format_exp.py export_files/ATIVIDADES_DATA_TABLE.json
python format_exp.py export_files/CONCELHOS_DATA_TABLE.json
python format_exp.py export_files/DISTRITOS_DATA_TABLE.json
python format_exp.py export_files/RECINTOS_DATA_TABLE.json
python format_exp.py export_files/REGIOES_DATA_TABLE.json
python format_exp.py export_files/TIPOS_DATA_TABLE.json
python format_exp.py export_files/USOS_DATA_TABLE.json
mongoimport --db tbda --collection atividades --file export_files/ATIVIDADES_DATA_TABLE.json --mode upsert
mongoimport --db tbda --collection concelhos --file export_files/CONCELHOS_DATA_TABLE.json --mode upsert
mongoimport --db tbda --collection distritos --file export_files/DISTRITOS_DATA_TABLE.json --mode upsert
mongoimport --db tbda --collection recintos --file export_files/RECINTOS_DATA_TABLE.json --mode upsert
mongoimport --db tbda --collection regioes --file export_files/REGIOES_DATA_TABLE.json --mode upsert
mongoimport --db tbda --collection tipos --file export_files/TIPOS_DATA_TABLE.json --mode upsert
mongoimport --db tbda --collection usos --file export_files/USOS_DATA_TABLE.json --mode upsert