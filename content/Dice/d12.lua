HRLR_UTIL.Dice {
  key = "d12",
  atlas = "placeholder",

  pos = { x = 0, y = 0 },

  config = {
    extra = {
      value = nil,
      sides = 12,
      rolled = false,
      immediate = true
    }
  },

  loc_vars = function(self, info_queue, card)
    local value = card.ability.extra.value or "(d12)"
    return { vars = {
      value
    }}
  end,

  effect = function(self, card, context)
    ease_dollars(card.ability.extra.value)
  end
}
