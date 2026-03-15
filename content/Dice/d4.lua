HRLR_UTIL.Dice {
  key = "d4",
  atlas = "dice",

  pos = { x = 0, y = 0 },

  config = {
    extra = {
      sides = 4
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
      return {
        level_up = card.ability.extra.value,
        message = localize('k_level_up_ex')
      }
    end
    if context.after and card.ability.extra.rolled then
      SMODS.destroy_cards(card)
      return {
        level_up = -card.ability.extra.value
      }
    end
  end
}
