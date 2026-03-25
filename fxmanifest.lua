fx_version "cerulean"
games {"gta5"}

description "Remove the default GTA V map."
author "L1CKS"
version "2.0.0"

files {
    "water.xml",
    "traintracks.xml",
    "client.lua",
    "distantlights.dat",
    "distantlights_hd.dat",
    -- "heightmap.dat",
    -- "popcycle.dat",
    -- "popzone.ipl",
}

client_scripts {
    "client.lua"
}

this_is_a_map "yes"

data_file "TRAINTRACK_FILE" "traintracks.xml"