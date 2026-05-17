SMODS.Joker {
  key = "bardic_inspiration",
  atlas = "jokers",
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
  end,

  joker_display_def = function(JokerDisplay)
    return {
      text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count" }
      },
      calc_function = function(card)
        card.joker_display_values.active = (G.GAME.current_round.hands_left == 2 and G.STATE == G.STATES.SELECTING_HAND)
                                           or (G.GAME.current_round.hands_left == 1 and G.STATE == G.STATES.HAND_PLAYED)
        local free_space = G.consumeables.config.card_limit - #G.consumeables.cards
        card.joker_display_values.count = math.min(2, math.max(0, free_space))
      end,
      style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] and text.children[2] then
          local color = card.joker_display_values.active and G.C.SECONDARY_SET.hrlr_dice or G.C.UI.TEXT_INACTIVE
          text.children[1].config.colour = color
          text.children[2].config.colour = color
        end
      end
    }
  end
}
