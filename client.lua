Citizen.CreateThread(function()

    -- wait until player loads before swapping water metadata
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(100)
    end
    
    Citizen.Wait(1000)

    local load_cayo = false
    if config ~= nil and config.cayo_perico ~= nil then
        load_cayo = config.cayo_perico
    end

    if load_cayo then
        LoadGlobalWaterType(1)  -- important to set this, otherwise LS water tiles will not load
        SetDeepOceanScaler(0.0)
        LoadWaterFromPath(GetCurrentResourceName(), 'water_ls_cayo.xml')
    else
        -- do NOT set any global water type when loading water in the LS bounding box
        LoadWaterFromPath(GetCurrentResourceName(), 'water.xml')
    end

    SetFogVolumeRenderDisabled(true)    -- remove light pollution effects
    DisableVehicleDistantlights(true)   -- remove vehicle lod lights
end)