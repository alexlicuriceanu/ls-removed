config = {}

config.disable_ambient_sounds = true   -- disable ambient sounds like traffic, sirens. note: also disables Cayo Perico ambient sounds

config.custom_water_name = 'ls_cayo_water'   -- set to nil to disable, or set to a key in config.custom_water to load a custom water file
config.custom_water = {
    ['ls_water'] = {
        resource_name = GetCurrentResourceName(), path = 'data/water.xml'
    },
    ['ls_cayo_water'] = {
        resource_name = GetCurrentResourceName(), path = 'data/ls_cayo_water.xml', deep_ocean_scaler = 0.0, global_water_type = 1
    },

    -- example custom water config, you can use water from another resource or with different settings
    -- by adding a new entry here and setting config.use_custom_water to the key of that entry:
    -- 
    -- Parameters: 
    --['your_water_name'] = {
    --    resource_name = 'your_resource_name', path = 'path/to/your/water.xml', deep_ocean_scaler = 0.0, global_water_type = 1
    --}
}

config.passes = 3
config.pass_delay = 1000