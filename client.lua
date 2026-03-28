Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(100)
    end

    -- main map removal
    local batch_size = 100
    for i, ipl in ipairs(ls_ipls) do
        RemoveIpl(ipl)

        if i % batch_size == 0 then
            Citizen.Wait(0)
        end
    end

    -- second pass for any ipl that may have been reloaded
    for _, ipl in ipairs(ls_ipls) do
        if IsIplActive(ipl) then
            RemoveIpl(ipl)
        end
    end
end)
