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
  end,

  set_sprites = function(self, card, front)
    sprite_table = {
      canvasW = 71, canvasH = 95,
      text_offset = { x = 36, y = 21 },
      text_colour = G.C.UI.TEXT_DARK,
      text_width = 30,
      text_height = 20,
      text = "?"
    }
    if card.ability then
      sprite_table.ref_table = card.ability.extra
      sprite_table.ref_value = "value"
    end
    card.children.canvas_text = SMODS.CanvasSprite(sprite_table)
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
