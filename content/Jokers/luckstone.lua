SMODS.Joker {
  key = "luckstone",
  atlas = "jokers",
  pos = { x = 3, y = 0 },
  rarity = 3,
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  config = { extra = {
    scale = 0.5
  }},

  loc_vars = function(self, info_queue, card)
    return { vars = { 1 + card.ability.extra.scale } }
  end,

  calculate = function(self, card, context)
    if context.hrlr_modify_bounds then
      return {
        hrlr_max_mod = context.hrlr_die_sides * card.ability.extra.scale
      }
    end
  end
}
