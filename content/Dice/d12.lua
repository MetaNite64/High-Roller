HRLR_UTIL.Dice {
  key = "d12",
  atlas = "placeholder",

  pos = { x = 0, y = 0 },

  config = {
    extra = {
      value = nil,
      sides = 12,
      rolled = false
    }
  },

  loc_vars = function(self, info_queue, card)
    local value = card.ability.extra.value or "(d12)"
    return { vars = {
      value
    }}
  end,

  calc_dollar_bonus = function(self, card)
    if card.ability.extra.rolled then
      local dollar_bonus = card.ability.extra.value
      SMODS.destroy_cards(card)
      return dollar_bonus
    end
  end
}
