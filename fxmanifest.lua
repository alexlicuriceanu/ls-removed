fx_version "cerulean"
games {"gta5"}

description "Remove the default GTA V map."
author "L1CKS"
version "2.0.0"

files {
	"empty.meta",
	"images.meta",
	"water.xml",
	"traintracks.xml",
	"distantlights.dat",
	"distantlights_hd.dat",
	"heightmap.dat",
	"popcycle.dat",
	"popzone.ipl",
	"sp_manifest.ymt"
}

replace_level_meta "empty"

data_file "SCENARIO_POINTS_OVERRIDE_PSO_FILE" "sp_manifest.ymt"
data_file "TRAINTRACK_FILE" "traintracks.xml"