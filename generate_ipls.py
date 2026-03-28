input_file = 'ymaps_list.txt'
output_file = 'ipls.lua'

def get_lod_rank(name):
    name_lower = name.lower()
    if 'slod4' in name_lower: return 5
    if 'slod3' in name_lower: return 4
    if 'slod2' in name_lower: return 3
    if 'slod' in name_lower: return 2
    if 'lod' in name_lower: return 1
    return 0

with open(input_file, 'r') as f:
    ymap_names = [line.strip().replace('.ymap', '').replace('.YMAP', '') for line in f if line.strip()]

ymap_names.sort(key=get_lod_rank)

with open(output_file, 'w') as f:   
    f.write("ls_ipls = {\n")
    
    for i, name in enumerate(ymap_names):
        if i == len(ymap_names) - 1:
            f.write(f'    "{name}"\n')
        else:
            f.write(f'    "{name}",\n')
            
    f.write("}\n\n")

print(f"Done: {len(ymap_names)} sorted IPLs written to {output_file}")