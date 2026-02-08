HRLR_UTIL.Dice {
  key = "d12",
  atlas = "dice",

  pos = { x = 4, y = 0 },

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
    local roll = HRLR_UTIL.useDie(card)

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 1.3,
      func = function()
        card.ability.extra.value = roll
        ease_dollars(roll)
        SMODS.destroy_cards(card)
        return true
      end
    }))
  end
}
