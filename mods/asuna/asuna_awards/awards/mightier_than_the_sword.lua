return function(award)
  minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "default:book" and fields.save and fields.title and fields.text then
      awards.unlock(player:get_player_name(),award)
    end
  end)

  return {
    title = "Mightier Than the Sword",
    description = "Write a book",
    difficulty = 135,
    icon = "default_book_written.png",
  }
end