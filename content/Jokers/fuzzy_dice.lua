SMODS.Joker {
  key = "fuzzy_dice",
  atlas = "placeholder",
  pos = { x = 0, y = 0 },
  rarity = 1,
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,

  config = { extra = { chips = 0 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,

  calculate = function(self, card, context)
    if context.hrlr_post_roll then
      card.ability.extra.chips = card.ability.extra.chips + context.hrlr_roll_value
    end

    if context.joker_main then
      return {
        chips = card.ability.extra.chips
      }
    end
  end
}
