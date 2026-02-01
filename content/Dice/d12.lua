HRLR_UTIL.Dice {
  key = "d12",
  atlas = "placeholder",

  pos = { x = 0, y = 0 },

  config = {
    extra = {
      sides = 12
    }
  },

  loc_vars = function(self, info_queue, card)
    local value = card.ability.extra.value or "(d12)"
    return { vars = {
      value
    }}
  end,

  use = function(self, card, area)
    HRLR_UTIL.useDie(card)

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 1.3,
      func = function()
        ease_dollars(card.ability.extra.value)
        SMODS.destroy_cards(card)
        return true
      end
    }))
  end
}
