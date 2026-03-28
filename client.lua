-- function that calls RemoveIpl for each ipl in a list
-- @param ipls list of ipl names to remove
-- @return none
local function RemoveIpls(ipls) 
    for _, ipl in ipairs(ipls) do
        RemoveIpl(ipl)
    end
end

Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(100)
    end

    -- ### MAIN MAP REMOVAL ###
    for i = 1, config.passes do
        if config.debug then
            print(string.format('Removing LS, pass %d/%d...', i, config.passes))
        end
        RemoveIpls(_ls_ipls)
        Citizen.Wait(config.pass_delay)
    end

    SetFogVolumeRenderDisabled(true)    -- remove light pollution effects
    DisableVehicleDistantlights(true)   -- remove vehicle lod lights


    -- ### WATER ###
    local load_cayo = false
    if config ~= nil and config.cayo_perico ~= nil then
        load_cayo = config.cayo_perico
    end

    if load_cayo then
        LoadGlobalWaterType(1)  -- important to set this, otherwise LS water tiles will not load
        SetDeepOceanScaler(0.0)
        LoadWaterFromPath(GetCurrentResourceName(), 'data/water_ls_cayo.xml')
    else
        -- do NOT set any global water type when loading water in the LS bounding box
        LoadWaterFromPath(GetCurrentResourceName(), 'data/water.xml')
    end

    -- if the user wants to load the water file from somewhere else
    if config.use_custom_water and config.custom_water then
        if config.custom_water.global_water_type then
            LoadGlobalWaterType(config.custom_water.global_water_type)
        end

        if config.custom_water.deep_ocean_scaler then
            SetDeepOceanScaler(config.custom_water.deep_ocean_scaler)
        end

        if config.custom_water.path and config.custom_water.resource_name then
            LoadWaterFromPath(config.custom_water.resource_name, config.custom_water.path)

            if config.debug then
                print(string.format('Loaded water from resource %s, path %s', config.custom_water.resource_name, config.custom_water.path))
            end
        end
    end


    -- ### CAYO PERICO LOADING ###
    if config.cayo_perico then
        for _, ipl in ipairs(_cayo_ipls) do
            RequestIpl(ipl)
        end

        -- misc natives
        SetAiGlobalPathNodesType(1)
        LoadGlobalWaterType(1)
        SetZoneEnabled(GetZoneFromNameId("PrLog"), false)
        --SetScenarioGroupEnabled('Heist_Island_Peds', true)

        -- audio stuff
        SetAudioFlag('PlayerOnDLCHeist4Island', true)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
    end
end)
