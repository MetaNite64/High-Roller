-- define the new Dice consumable type
SMODS.ConsumableType {
  key = "dice",
  prefix_config = { key = true },
  text_colour = HRLR_UTIL.colors.DICE_TEXT,
  primary_colour = HRLR_UTIL.colors.DICE_BG,
  secondary_colour = HRLR_UTIL.colors.DICE_BG,
  shop_rate = 0,
  default = 'c_hrlr_d6',
  collection_rows = { 4, 3 }
}

-- dice consumables extend SMODS.Consumable
HRLR_UTIL.Dice = SMODS.Consumable:extend {
  set = "hrlr_dice",
  unlocked = true,
  discovered = false,

  inject = function(self)
    SMODS.Consumable.inject(self)
    G.shared_dice[self.key] = SMODS.CanvasSprite(0, 0, G.CARD_W, G.CARD_H, 71, 95, 10)
  end,

  can_use = function(self, card)
    return not card.ability.extra.rolled
  end,

  keep_on_use = function(self, card)
    return true
  end,

  use = function(self, card, area)
    local roll = HRLR_UTIL.useDie(card)

    -- unspotlight card
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 1.3,
      func = function()
        draw_card(G.play, G.consumeables, 1, 'up', true, card, nil, mute)
        card.ability.extra.value = roll
        return true
      end
    }))
  end
}
