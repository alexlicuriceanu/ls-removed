Citizen.CreateThread(function()

    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(100)
    end
    
    Citizen.Wait(1000)

    local load_cayo = false
    if config ~= nil and config.cayo_perico ~= nil then
        load_cayo = config.cayo_perico
    end

    if load_cayo then
        LoadGlobalWaterType(1)
        SetDeepOceanScaler(0.0)
        LoadWaterFromPath(GetCurrentResourceName(), 'water_ls_cayo.xml')
    else
        LoadWaterFromPath(GetCurrentResourceName(), 'water.xml')
    end

    SetFogVolumeRenderDisabled(true)
end)