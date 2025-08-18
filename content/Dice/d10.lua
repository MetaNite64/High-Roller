HRLR_UTIL.Dice {
  key = "d10",
  atlas = "placeholder",

  pos = { x = 0, y = 0 },

  config = {
    extra = {
      value = nil,
      sides = 6,
      rolled = false
    }
  },

  loc_vars = function(self, info_queue, card)
    local value = card.ability.extra.value and (card.ability.extra.value * 10 .. "%") or "10% X (d10)"
    return { vars = {
      value
    }}
  end,

  calculate = function(self, card, context)
    if context.final_scoring_step and card.ability.extra.rolled then
      SMODS.destroy_cards(card)
      HRLR_UTIL.balanceScore(card.ability.extra.value / 10, card)
    end
  end
}
