--[[
  Day or night
]]

music.register_track({
  name = "reparateur",
  length = 200 + 30,
  gain = 1.25,
  day = true,
  night = true,
  ymin = -12,
  ymax = 31000,
})

music.register_track({
  name = "blood",
  length = 89 + 30,
  gain = 1,
  day = true,
  night = true,
  ymin = -12,
  ymax = 31000,
})

--[[
  Daytime only
]]

for track,length in pairs({
  castlesinthesky = 107,
  firefly = 152,
  bathedinthelight = 166,
  roquefortprolog = 85,
  meditatingbeat = 132,
  pond = 142,
  onefineday = 51,
  antarctica = 65,
  simplicity = 122,
  endtitles = 135,
  imagefilm033 = 121,
}) do
  music.register_track({
    name = track,
    length = length + 30,
    gain = 1,
    day = true,
    night = false,
    ymin = -12,
    ymax = 31000,
  })
end

--[[
  Nighttime only
]]

for track,length in pairs({
  jul = 204,
  skyward = 149,
  thelongwayhome = 171,
  --moonlight = 176,
  --walkingstars = 172,
  hymn = 73,
  reverie = 136,
  atemubungen = 177,
  breezyreflections = 91,
  dreamsphere1 = 177,
  dreamsphere2 = 109,
  dreamsphere4 = 104,
  lonelyfish = 107,
}) do
  music.register_track({
    name = track,
    length = length + 30,
    gain = 1,
    day = false,
    night = true,
    ymin = -12,
    ymax = 31000,
  })
end

--[[
  Underground
]]

for track,length in pairs({
  machina = 192,
  tearsinrain = 172,
  screensaver = 113,
  cobalt = 176,
  infinitepeace = 73,
  thevisitors = 160,
  sunriseonmars = 129,
}) do
  music.register_track({
    name = track,
    length = length + 30,
    gain = 1,
    day = true,
    night = true,
    ymin = -31000,
    ymax = -12,
  })
end