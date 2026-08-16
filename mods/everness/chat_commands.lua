local S = core.get_translator(core.get_current_modname())

core.register_chatcommand('everness:getbiomename', {
    description = S('Get biome name where you are standing.'),
    params = '',
    privs = { creative = true },
    func = function(name, param)
        local player = core.get_player_by_name(name)

        if not player then
            return false, S('This command can only be executed in-game!')
        end

        local p_pos = player:get_pos()
        local biome_data = core.get_biome_data(p_pos)

        if not biome_data then
            return false
        end

        local biome_name = core.get_biome_name(biome_data.biome)

        core.chat_send_player(name, 'Biome name: ' .. biome_name)
    end,
})
