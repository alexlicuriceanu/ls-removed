config = {}
config.debug = true
config.cayo_perico = true

config.use_custom_water = false
config.custom_water = {
    resource_name = GetCurrentResourceName(), path = 'data/water.xml', deep_ocean_scaler = 0.0, global_water_type = 1
}

config.passes = 2
config.pass_delay = 1000