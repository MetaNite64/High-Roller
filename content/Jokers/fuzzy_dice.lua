SMODS.Joker {
  key = "fuzzy_dice",
  atlas = "jokers",
  pos = { x = 2, y = 0 },
  rarity = 1,
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,

  config = { extra = { chips = 0, change = 0 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,

  calculate = function(self, card, context)
    if context.hrlr_post_roll then
      card.ability.extra.change = 0.5 * context.hrlr_roll_value
      SMODS.scale_card(card, {
        ref_table = card.ability.extra,
        ref_value = "chips",
        scalar_value = "change",
        message_key = "a_chips",
        message_colour = G.C.BLUE
      })
    end

    if context.joker_main then
      return {
        chips = card.ability.extra.chips
      }
    end
  end
}
