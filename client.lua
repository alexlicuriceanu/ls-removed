Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(100)
    end

    -- ### MAIN MAP REMOVAL ###
    local batch_size = 100
    for i, ipl in ipairs(_ls_ipls) do
        RemoveIpl(ipl)

        if i % batch_size == 0 then
            Citizen.Wait(0)
        end
    end

    -- second pass for any ipl that may have been reloaded
    for _, ipl in ipairs(_ls_ipls) do
        if IsIplActive(ipl) then
            RemoveIpl(ipl)
        end
    end

    SetFogVolumeRenderDisabled(true)    -- remove light pollution effects
    DisableVehicleDistantlights(true)   -- remove vehicle lod lights
end)
