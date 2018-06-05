import json

if __name__ == "__main__":
    # importing regioes
    reg_f = open('export_files/REGIOES_DATA_TABLE.json','r+',encoding='utf8')
    reg_data = reg_f.read()[:-1].replace(',"items":\n[\n','[')
    reg_json = json.loads(reg_data)
    reg_f.close()

    for reg in reg_json:
        reg['_id'] = reg['cod']
        del reg['cod']

    reg_data = json.dumps(reg_json, ensure_ascii=False)[1:-1].replace('}, {','}\n{')

    # save regioes
    reg_out = open('imports/regioesR.json','w',encoding='utf8')
    reg_out.seek(0)
    reg_out.truncate
    reg_out.write(reg_data)
        

    # importing distritos
    dist_f = open('export_files/DISTRITOS_DATA_TABLE.json','r+',encoding='utf8')
    dist_data = dist_f.read()[:-1].replace(',"items":\n[\n','[')
    dist_json = json.loads(dist_data)
    dist_f.close()

    # replacing regiao id by regiao reference
    for dist in dist_json:
        if 'regiao' in dist:
            if isinstance(dist['regiao'],int):
                for reg in reg_json:
                    if reg['_id'] == dist['regiao']:
                        dist['regiao'] = reg
        dist['_id'] = dist['cod']
        del dist['cod']
    
    dist_data = json.dumps(dist_json, ensure_ascii=False)[1:-1].replace('}, {','}\n{')
    
    # save distritos with reference to regiao
    dist_out = open('imports/distritosR.json','w',encoding='utf8')
    dist_out.seek(0)
    dist_out.truncate
    dist_out.write(dist_data)

    # importing concelhos
    conc_f = open('export_files/CONCELHOS_DATA_TABLE.json','r+',encoding='utf8')
    conc_data = conc_f.read()[:-1].replace(',"items":\n[\n','[')
    conc_json = json.loads(conc_data)
    conc_f.close()

    for conc in conc_json:
        if 'regiao' in conc:
            if isinstance(conc['regiao'],int):
                for reg in reg_json:
                    if reg['_id'] == conc['regiao']:
                        conc['regiao'] = reg
        if 'distrito' in conc:
            if isinstance(conc['distrito'],int):
                for dist in dist_json:
                    if dist['_id'] == conc['distrito']:
                        conc['distrito'] = dist
        conc['_id'] = conc['cod']
        del conc['cod']

    conc_data = json.dumps(conc_json, ensure_ascii=False)[1:-1].replace('}, {','}\n{')

    # save concelhos with reference to regiao and to distrito
    conc_out = open('imports/concelhosR.json','w',encoding='utf8')
    conc_out.seek(0)
    conc_out.truncate
    conc_out.write(conc_data)

    # importing recintos
    rec_f = open('export_files/RECINTOS_DATA_TABLE.json','r+',encoding='utf8')
    rec_data = rec_f.read()[:-1].replace(',"items":\n[\n','[')
    rec_json = json.loads(rec_data)
    rec_f.close()

    # importing tipos
    tip_f = open('export_files/TIPOS_DATA_TABLE.json','r+',encoding='utf8')
    tip_data = tip_f.read()[:-1].replace(',"items":\n[\n','[')
    tip_json = json.loads(tip_data)
    tip_f.close()

    for rec in rec_json:
        if 'concelho' in rec:
            if isinstance(rec['concelho'],int):
                for conc in conc_json:
                    if conc['_id'] == rec['concelho']:
                        rec['concelho'] = conc
        if 'tipo' in rec:
            if isinstance(rec['tipo'],int):
                for tip in tip_json:
                    if tip['tipo'] == rec['tipo']:
                        rec['tipo'] = tip['descricao']
        rec['_id'] = rec['id']
        del rec['id']

    rec_data = json.dumps(rec_json, ensure_ascii=False)[1:-1].replace('}, {','}\n{')

    # save recintos with reference to concelho and to tipo
    rec_out = open('imports/recintosR.json','w',encoding='utf8')
    rec_out.seek(0)
    rec_out.truncate
    rec_out.write(rec_data)

    # importing usos
    uso_f = open('export_files/USOS_DATA_TABLE.json','r+',encoding='utf8')
    uso_data = uso_f.read()[:-1].replace(',"items":\n[\n','[')
    uso_json = json.loads(uso_data)
    uso_f.close()

    # importing atividades
    ati_f = open('export_files/ATIVIDADES_DATA_TABLE.json','r+',encoding='utf8')
    ati_data = ati_f.read()[:-1].replace(',"items":\n[\n','[')
    ati_json = json.loads(ati_data)
    ati_f.close()
    
    
    for uso in uso_json:
        if 'id' in uso:
            if isinstance(uso['id'],int):
                for rec in rec_json:
                    if 'atividades' not in rec:
                        rec['atividades'] = []
                    if rec['_id'] == uso['id']:
                        rec['atividades'].append(uso['ref'])

    for rec in rec_json:
        for n, i in enumerate(rec['atividades']):
            for ati in ati_json:
                if i == ati['ref']:
                    rec['atividades'][n] = ati['atividade']
    
    rec_data = json.dumps(rec_json, ensure_ascii=False)[1:-1].replace('}, {','}\n{')

    # save recintos with reference to concelho and to tipo
    rec_out = open('imports/recintosR.json','w',encoding='utf8')
    rec_out.seek(0)
    rec_out.truncate
    rec_out.write(rec_data)    
            