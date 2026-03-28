import os

input_file = 'ymaps_list.txt'
output_file = 'client_remove_ls.lua'

# The engine fallback ranking system
def get_lod_rank(name):
    name_lower = name.lower()
    if 'slod4' in name_lower: return 5
    if 'slod3' in name_lower: return 4
    if 'slod2' in name_lower: return 3
    if 'slod' in name_lower: return 2
    if 'lod' in name_lower: return 1
    return 0 # High detail

with open(input_file, 'r') as f:
    # Read and clean the names
    ymap_names = [line.strip().replace('.ymap', '').replace('.YMAP', '') for line in f if line.strip()]

# THIS IS THE MAGIC: Sort the array sequentially by LOD rank (0 -> 5)
ymap_names.sort(key=get_lod_rank)

with open(output_file, 'w') as f:
    f.write("Citizen.CreateThread(function()\n")
    f.write("    while not NetworkIsPlayerActive(PlayerId()) do\n")
    f.write("        Citizen.Wait(0)\n")
    f.write("    end\n\n")
    
    f.write("    local ls_ipls = {\n")
    
    for i, name in enumerate(ymap_names):
        if i == len(ymap_names) - 1:
            f.write(f'        "{name}"\n')
        else:
            f.write(f'        "{name}",\n')
            
    f.write("    }\n\n")
    
    f.write("    local batch_size = 100\n")
    f.write("    for i, ipl in ipairs(ls_ipls) do\n")
    f.write("        RemoveIpl(ipl)\n")
    f.write("        if i % batch_size == 0 then\n")
    f.write("            Citizen.Wait(0)\n")
    f.write("        end\n")
    f.write("    end\n\n")
    
    f.write("    print('Los Santos has been successfully wiped (including LODs).')\n")
    f.write("end)\n")

print(f"Success! {len(ymap_names)} sorted IPLs written to {output_file}.")