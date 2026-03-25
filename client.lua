-- client.lua

-- A small list of IPLs for a specific chunk of Downtown Los Santos
local testIpls = {
    "dt1_05",         -- The High-Detail (HD) models and collisions
    "dt1_05_lod",     -- The Level of Detail (seen from medium distance)
    "dt1_05_slod1",   -- Super LOD 1 (seen from far away)
    "dt1_05_slod2",   -- Super LOD 2 (seen from very far away)
    "dt1_05_slod3",    -- Super LOD 3 (distant skyline)
    "hei_ap1_01_d_long_0",
    "hei_ap1_01_d",
    "hei_ap1_01_d_strm_0",
    'hei_ap1_01_a_strm_1',
    'hei_ap1_01_d_long_0',
    'hei_ap1_lod',
    "ap1_01_d_long_0",
    "ap1_01_d",
    "ap1_01_d_strm_0",
    'ap1_01_a_strm_1',
    'ap1_01_d_long_0',
    'ap1_lod'
}

Citizen.CreateThread(function()
    for _, ipl in ipairs(testIpls) do
        RemoveIpl(ipl)
    end

end, false)