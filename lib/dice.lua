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
    -- spotlight card, base roll
    draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
    local current_roll = HRLR_UTIL.rollDie(card)
    card.ability.extra.rolled = true

    -- check for rerolls
    local reroll_effects = {}
    SMODS.calculate_context({
      hrlr_add_rerolls = true,
      hrlr_other_die = card,
      hrlr_roll_value = current_roll
    }, reroll_effects)

    -- do rerolls
    for _, v in ipairs(reroll_effects) do
      for _, w in pairs(v) do
        if w.hrlr_rerolls then
          local reroll_table = { current_roll }
          for i = 1, w.hrlr_rerolls do table.insert(reroll_table, HRLR_UTIL.rollDie(card)) end
          if w.hrlr_reroll_determiner and type(w.hrlr_reroll_determiner) == "function" then
            current_roll = w.hrlr_reroll_determiner(reroll_table)
          else  -- by default, pick the max roll
            current_roll = math.max(unpack(reroll_table))
          end
        end
      end
    end

    -- unspotlight card
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 1.3,
      func = function()
        draw_card(G.play, G.consumeables, 1, 'up', true, card, nil, mute)
        card.ability.extra.value = current_roll
        return true
      end
    }))

    -- calculate post_roll context
    SMODS.calculate_context({
      hrlr_post_roll = true,
      hrlr_roll_value = card.ability.extra.value
    })
  end
}
