--[[
################### HIGH ROLLER ###################
################## by metanite64 ##################
#  A mod about dice, a brand new consumable type. #
#      7 Dice, one associated Spectral card,      #
#         one voucher set, and 4 Jokers.          #
###################################################
--]]

assert(SMODS.load_file("utilities.lua"))()

-- placeholder atlas
SMODS.Atlas {
  key = "placeholder",
  path = "placeholder.png",
  px = 71, py = 95
}

-- dice atlas
SMODS.Atlas {
  key = "dice",
  path = "dice.png",
  px = 71, py = 95
}

-- dice roll sfx
SMODS.Sound {
  key = "roll",
  path = "roll.ogg"
}

-- coin flip sfx
-- shoutouts to hakita "ultrakill" hakita
SMODS.Sound {
  key = "flip_coin",
  path = "flip_coin.ogg"
}

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

  set_sprites = function(self, card, front)
    card.children.center:set_sprite_pos({ x = card.ability and card.ability.extra.value or 0, y = card.config.center.pos.y })
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

    card.ability.extra.value = current_roll

    -- unspotlight card
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 1.3,
      func = function()
        --HARDCODED FOR NOW
        if card.ability.extra.sides == 6 then
          card.children.center:set_sprite_pos({ x = current_roll, y = card.config.center.pos.y })
        end
        draw_card(G.play, G.consumeables, 1, 'up', true, card, nil, mute)
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

HRLR_UTIL.loadItems(HRLR_UTIL.enabled_dice, "content/Dice")
HRLR_UTIL.loadItems(HRLR_UTIL.enabled_bags, "content/Boosters")
HRLR_UTIL.loadItems(HRLR_UTIL.enabled_jokers, "content/Jokers")
HRLR_UTIL.loadItems(HRLR_UTIL.enabled_misc, "content/Misc")
