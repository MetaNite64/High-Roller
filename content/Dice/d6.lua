HRLR_UTIL.Dice {
  key = "d6",
  atlas = "dice",

  pos = { x = 0, y = 0 },

  config = {
    extra = {
      value = nil,
      sides = 6,
      rolled = false
    }
  },

  loc_vars = function(self, info_queue, card)
    local value = card.ability.extra.value or "(d6)"
    return { vars = {
      value
    }}
  end,

  calculate = function(self, card, context)
    if context.final_scoring_step and card.ability.extra.rolled then
      SMODS.destroy_cards(card)
      return { xmult = card.ability.extra.value }
    end
  end
}
