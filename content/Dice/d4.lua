HRLR_UTIL.Dice {
  key = "d4",
  atlas = "placeholder",

  pos = { x = 0, y = 0 },

  config = {
    extra = {
      value = nil,
      sides = 4,
      rolled = false
    }
  },

  loc_vars = function(self, info_queue, card)
    local value = card.ability.extra.value or "(d4)"
    return { vars = {
      value
    }}
  end,

  calculate = function(self, card, context)
    if context.before and card.ability.extra.rolled then
      if card.ability.extra.value == 1 then SMODS.destroy_cards(card)
      else card.ability.extra.value = card.ability.extra.value - 1 end
      return {
        level_up = 1,
        message = localize('k_level_up_ex')
      }
    end
  end
}
