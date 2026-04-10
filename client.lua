-- function that calls RemoveIpl for each ipl in a list
-- @param ipls list of ipl names to remove
-- @return none
local function RemoveIpls(ipls) 
    for _, ipl in ipairs(ipls) do
        RemoveIpl(ipl)
    end
end

Citizen.CreateThread(function()
    SetFogVolumeRenderDisabled(true)    -- remove light pollution effects
    DisableVehicleDistantlights(true)   -- remove vehicle lod lights
    DisableWorldhorizonRendering(true)   -- disable farlods rendering

    -- ### WATER ###
    if config.custom_water_name and config.custom_water then
        local custom_water_name = config.custom_water_name
        local custom_water = config.custom_water[custom_water_name]
        
        LoadWaterFromPath(custom_water.resource_name, custom_water.path)

        if custom_water.global_water_type then
            LoadGlobalWaterType(custom_water.global_water_type)
        end
        if custom_water.deep_ocean_scaler then
            SetDeepOceanScaler(custom_water.deep_ocean_scaler * 1.0)
        end

        if config.debug then
            print(string.format('Loaded custom water %s from resource %s, path %s', custom_water_name, custom_water.resource_name, custom_water.path))
        end
    end

    -- wait until player is active before removing ipls
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(100)
    end

    -- ### MAIN MAP REMOVAL ###
    -- for i = 1, config.passes do
    --     if config.debug then
    --         print(string.format('Removing Los Santos IPLs, pass %d/%d...', i, config.passes))
    --     end
        
    --     RemoveIpls(_ipls)
    --     Citizen.Wait(config.pass_delay)
    -- end
end)


-- handle water fog textures
Citizen.CreateThread(function()
    local id = PlayerId()

    while not NetworkIsPlayerActive(id) do
        Citizen.Wait(0)
    end

    RequestStreamedTextureDict("waterfog-0")
    while not HasStreamedTextureDictLoaded("waterfog-0") do
        Citizen.Wait(0)
    end

    AddReplaceTexture("platform:/textures/graphics", "waterfog", "waterfog-0", "waterfog-0")
    SetStreamedTextureDictAsNoLongerNeeded("waterfog-0")

    if config.debug then
        print('Replaced waterfog texture')
    end
end)
