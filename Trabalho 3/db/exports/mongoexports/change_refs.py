import json

if __name__ == "__main__":
    # importing regioes
    reg_f = open('regioes.json','r+',encoding='utf8')
    reg_data = reg_f.read()
    reg_data = reg_data.replace('}\n{','},{')
    reg_data = '[' + reg_data + ']'
    reg_json = json.loads(reg_data)
    reg_f.close()

    # importing distritos
    dist_f = open('distritos.json','r+',encoding='utf8')
    dist_data = dist_f.read()
    dist_data = dist_data.replace('}\n{','},{')
    dist_data = '[' + dist_data + ']'
    dist_json = json.loads(dist_data)
    dist_f.close()

    # replacing regiao id by regiao reference
    for dist in dist_json:
        if 'regiao' in dist:
            if isinstance(dist['regiao'],int):
                for reg in reg_json:
                    if reg['cod'] == dist['regiao']:
                        dist['regiao'] = reg['_id']
    
    dist_data = json.dumps(dist_json, ensure_ascii=False)[1:-1].replace('}, {','}\n{')
    
    # save distritos with reference to regiao
    dist_out = open('imports/distritosR.json','w',encoding='utf8')
    dist_out.seek(0)
    dist_out.truncate
    dist_out.write(dist_data)

    # importing concelhos
    conc_f = open('concelhos.json','r+',encoding='utf8')
    conc_data = conc_f.read()
    conc_data = conc_data.replace('}\n{','},{')
    conc_data = '[' + conc_data + ']'
    conc_json = json.loads(conc_data)
    conc_f.close()

    for conc in conc_json:
        if 'regiao' in conc:
            if isinstance(conc['regiao'],int):
                for reg in reg_json:
                    if reg['cod'] == conc['regiao']:
                        conc['regiao'] = reg['_id']
        if 'distrito' in conc:
            if isinstance(conc['distrito'],int):
                for dist in dist_json:
                    if dist['cod'] == conc['distrito']:
                        conc['distrito'] = dist['_id']

    conc_data = json.dumps(conc_json, ensure_ascii=False)[1:-1].replace('}, {','}\n{')

    # save concelhos with reference to regiao and to distrito
    conc_out = open('imports/concelhosR.json','w',encoding='utf8')
    conc_out.seek(0)
    conc_out.truncate
    conc_out.write(conc_data)

    # importing recintos
    rec_f = open('recintos.json','r+',encoding='utf8')
    rec_data = rec_f.read()
    rec_data = rec_data.replace('}\n{','},{')
    rec_data = '[' + rec_data + ']'
    rec_json = json.loads(rec_data)
    rec_f.close()

    # importing tipos
    tip_f = open('tipos.json','r+',encoding='utf8')
    tip_data = tip_f.read()
    tip_data = tip_data.replace('}\n{','},{')
    tip_data = '[' + tip_data + ']'
    tip_json = json.loads(tip_data)
    tip_f.close()

    for rec in rec_json:
        if 'concelho' in rec:
            if isinstance(rec['concelho'],int):
                for conc in conc_json:
                    if conc['cod'] == rec['concelho']:
                        rec['concelho'] = conc['_id']
        if 'tipo' in rec:
            if isinstance(rec['tipo'],int):
                for tip in tip_json:
                    if tip['tipo'] == rec['tipo']:
                        rec['tipo'] = tip['_id']

    rec_data = json.dumps(rec_json, ensure_ascii=False)[1:-1].replace('}, {','}\n{')

    # save recintos with reference to concelho and to tipo
    rec_out = open('imports/recintosR.json','w',encoding='utf8')
    rec_out.seek(0)
    rec_out.truncate
    rec_out.write(rec_data)

    # importing usos
    uso_f = open('usos.json','r+',encoding='utf8')
    uso_data = uso_f.read()
    uso_data = uso_data.replace('}\n{','},{')
    uso_data = '[' + uso_data + ']'
    uso_json = json.loads(uso_data)
    uso_f.close()

    # importing atividades
    ati_f = open('atividades.json','r+',encoding='utf8')
    ati_data = ati_f.read()
    ati_data = ati_data.replace('}\n{','},{')
    ati_data = '[' + ati_data + ']'
    ati_json = json.loads(ati_data)
    ati_f.close()
'''
    for uso in uso_json:
        if 'concelho' in uso:
            if isinstance(uso['concelho'],int):
                for conc in conc_json:
                    if conc['cod'] == uso['concelho']:
                        uso['concelho'] = conc['_id']
        if 'tipo' in uso:
            if isinstance(uso['tipo'],int):
                for tip in tip_json:
                    if tip['tipo'] == uso['tipo']:
                        uso['tipo'] = tip['_id']
    uso_data = json.dumps(uso_json, ensure_ascii=False)[1:-1].replace('}, {','}\n{')

    # save usos with reference to recinto and to atividade
    uso_out = open('imports/usosR.json','w',encoding='utf8')
    uso_out.seek(0)
    uso_out.truncate
    uso_out.write(uso_data)
'''

    

                
            