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

    -- ### MAIN MAP REMOVAL ###
    for i = 1, config.passes do
        if config.debug then
            print(string.format('Removing Los Santos IPLs, pass %d/%d...', i, config.passes))
        end
        
        RemoveIpls(_ls_ipls)
        Citizen.Wait(config.pass_delay)
    end

    SetFogVolumeRenderDisabled(true)    -- remove light pollution effects
    DisableVehicleDistantlights(true)   -- remove vehicle lod lights
    DisableWorldhorizonRendering(true)   -- disable farlods rendering

    -- ### CAYO PERICO LOADING ###
    -- if config.cayo_perico then
    --     for _, ipl in ipairs(_cayo_ipls) do
    --         RequestIpl(ipl)
    --     end

    --     -- misc natives
    --     SetAiGlobalPathNodesType(1)
    --     LoadGlobalWaterType(1)
    --     SetZoneEnabled(GetZoneFromNameId("PrLog"), false)
    --     SetScenarioGroupEnabled('Heist_Island_Peds', true)

    --     -- audio stuff
    --     SetAudioFlag('PlayerOnDLCHeist4Island', true)
    --     SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
    --     SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
    -- end
end)
