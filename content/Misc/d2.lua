SMODS.Consumable {
  key = "d2",
  set = "Spectral",
  
  atlas = "placeholder",
  pos = { x = 0, y = 0 },

  hidden = true,
  soul_set = "hrlr_dice",

  config = { extra = {
    flipped = false,
    roll_bonus = 0,
    tails_active = false
  } },

  can_use = function(self, card)
    return not card.ability.extra.flipped
  end,

  keep_on_use = function(self, card)
    return true
  end,

  use = function(self, card, area)
    draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
    local flip = pseudorandom('flip_coin')
    card.ability.extra.flipped = true
    local heads = (flip >= 0.5)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 1.3,
      func = function()
        card:juice_up(0.8, 0.5)
        play_sound("hrlr_flip_coin")
        card.ability.extra.roll_bonus = heads and card.ability.extra.roll_bonus + 1 or 0
        card.ability.extra.tails_active = not heads
        card.children.canvas_text.text = "+" .. card.ability.extra.roll_bonus
        return true
      end
    }))
    -- unspotlight card
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.9,
      func = function()
        draw_card(G.play, G.consumeables, 1, 'up', true, card, nil, mute)
        return true
      end
    }))
    delay(0.6)
  end,

  calculate = function(self, card, context)
    if context.hrlr_dice_mod then
      if card.ability.extra.roll_bonus > 0 then
        return {
          message = "Bonus!",
          colour = G.C.SECONDARY_SET.Spectral,
          hrlr_roll_value = math.min(context.hrlr_roll_value + card.ability.extra.roll_bonus, context.hrlr_die_sides)
        }
      end
      if card.ability.extra.tails_active then
        card.ability.extra.tails_active = false
        return {
          message = "Crit!",
          colour = G.C.SECONDARY_SET.Spectral,
          hrlr_roll_value = context.hrlr_die_sides
        }
      end
    end
    if context.end_of_round and context.main_eval then
      card.ability.extra.flipped = false
    end
  end,

  set_sprites = function(self, card, front)
  G.E_MANAGER:add_event(Event({
    blockable = false,
    func = function()
      card.children.canvas_text = SMODS.CanvasSprite {
        canvasW = 71, canvasH = 95,
        text_offset = { x = 36, y = 21 },
        text_colour = G.C.UI.TEXT_DARK,
        text_width = 30,
        text_height = 20,
        text = "+0"
      }
      return true
    end
  }))
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = {
      card.ability.extra.flipped and "Inactive..." or "Active!",
      card.ability.extra.roll_bonus,
      card.ability.extra.tails_active and "Active!" or "Inactive..."
    } }
  end
}
