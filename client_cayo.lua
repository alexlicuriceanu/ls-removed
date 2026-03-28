Citizen.CreateThread(function()
    for _, ipl in ipairs(config.ipls) do
        RequestIpl(ipl)
    end
end)