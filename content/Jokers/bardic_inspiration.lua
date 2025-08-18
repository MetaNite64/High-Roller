SMODS.Joker {
  key = "bardic_inspiration",
  atlas = "placeholder",
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.after and G.GAME.current_round.hands_left == 1 and hand_chips * mult < G.GAME.blind.chips then
      local spawned = 0
      for i = 1, 2 do
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          spawned = spawned + 1
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          G.E_MANAGER:add_event(Event({
            func = function()
              SMODS.add_card { set = 'hrlr_dice', key_append = 'j_hrlr_bardic_inspiration' }
              G.GAME.consumeable_buffer = 0
              return true
            end
          }))
        end
      end

      if spawned > 0 then
        return { message = localize('k_plus_dice_' .. spawned), colour = G.C.BLACK }
      end
    end
  end
}
