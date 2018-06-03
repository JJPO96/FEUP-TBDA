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

                
            