fx_version "cerulean"
games {"gta5"}

description "Remove the default GTA V map."
author "L1CKS"
version "2.0.0"

files {
    "water.xml",
    "water_ls_cayo.xml",
    "traintracks.xml",
    -- "heightmap.dat",
    -- "popcycle.dat",
    -- "popzone.ipl",
}

client_scripts {
    "config.lua",
    "client.lua",
}

this_is_a_map "yes"

data_file "TRAINTRACK_FILE" "traintracks.xml"
