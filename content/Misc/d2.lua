SMODS.Consumable {
  key = "d2",
  set = "Spectral",
  
  atlas = "placeholder",
  pos = { x = 0, y = 0 },

  hidden = true,
  soul_set = "hrlr_dice",

  can_use = function(self, card)
    if G.STATE == G.STATES.SPECTRAL_PACK then return G.consumeables.config.card_limit > #G.consumeables.cards
    else return G.consumeables.config.card_limit >= #G.consumeables.cards end
  end,

  use = function(self, card, area)
    local flip = pseudorandom('flip_coin')
    local to_create = flip >= 0.5 and 'c_black_hole' or 'c_soul'
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.9,
      func = function()
        card:juice_up(0.8, 0.5)
        play_sound('hrlr_flip_coin', 1, 1)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 1.3,
      func = function()
        if G.consumeables.config.card_limit >= #G.consumeables.cards then
          play_sound('timpani')
          SMODS.add_card({ key = to_create })
          card:juice_up(0.8, 0.5)
        end
        return true
      end
    }))
    delay(0.6)
  end
}
