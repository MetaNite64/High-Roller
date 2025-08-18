HRLR_UTIL.Dice {
  key = "d100",
  atlas = "placeholder",

  pos = { x = 0, y = 0 },

  config = {
    extra = {
      value = nil,
      sides = 100,
      rolled = false
    }
  },

  loc_vars = function(self, info_queue, card)
    local value = card.ability.extra.value or "(d100)"
    return { vars = {
      value
    }}
  end,

  calculate = function(self, card, context)
    if context.initial_scoring_step and card.ability.extra.rolled then
      SMODS.destroy_cards(card)
      return { chips = card.ability.extra.value }
    end
  end
}
