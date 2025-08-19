HRLR_UTIL = {}

-- Joker table
HRLR_UTIL.enabled_jokers = {
  "bardic_inspiration",
  "dice_goblin",
  "fuzzy_dice",
  "luckstone"
}

-- Dice table
HRLR_UTIL.enabled_dice = {
  "d4",
  "d6",
  "d8",
  "d10",
  "d12",
  "d20",
  "d100"
}

-- Dice Bag table
HRLR_UTIL.enabled_bags = {
  "dice_normal_1",
  "dice_normal_2",
  "dice_jumbo",
  "dice_mega"
}

-- Misc table
HRLR_UTIL.enabled_misc = {
  "d2",
  "advantage",
  "loaded_dice"
}

-- color definitions
HRLR_UTIL.colors = {
  DICE_BG = G.C.WHITE,
  DICE_TEXT = G.C.UI.TEXT_DARK,
}

-- function to load other files
function HRLR_UTIL.loadItems(names, path)
  for i = 1, #names do
    assert(SMODS.load_file(path .. "/" .. names[i] .. ".lua"))()
  end
end

-- update hrlr_roll_value in context.hrlr_dice_mod
local eval_card_ref = eval_card
eval_card = function(card, context)
  local ret, post = eval_card_ref(card, context)
  for _, v in pairs(ret) do
    if v.hrlr_roll_value then context.hrlr_roll_value = v.hrlr_roll_value end
  end
  return ret, post
end

-- die rolling function
function HRLR_UTIL.rollDie(die)
  local roll = pseudorandom('roll_die', 1, die.ability.extra.sides)
  local roll_graphics = roll
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 1.3,
    func = function()
      die:juice_up(0.8, 0.5)
      -- HARDCODED FOR NOW
      if die.ability.extra.sides == 6 then
        die.children.center:set_sprite_pos({ x = roll_graphics, y = 0 })
      end
      play_sound('hrlr_roll', 1, 1)
      return true
    end
  }))
  local modified = {}
  SMODS.calculate_context({
    hrlr_dice_mod = true,
    hrlr_die = die,
    hrlr_die_sides = die.ability.extra.sides,
    hrlr_roll_value = roll
  }, modified)
  delay(1.5)
  for _, v in ipairs(modified) do
    for _, w in pairs(v) do
      roll = w.hrlr_roll_value
      local roll_graphics = roll
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 1.1,
        func = function()
          die:juice_up(0.8, 0.5)
          --HARDCODED FOR NOW
          if die.ability.extra.sides == 6 then
            die.children.center:set_sprite_pos({ x = roll_graphics, y = 0 })
          end
          --play_sound('hrlr_dice_mod', 1, 1)
          return true
        end
      }))
      SMODS.trigger_effects({ v }, w.card)
    end
  end
  return roll
end

-- chip/mult percentage balancing function
-- shoutouts to paperback, which in turn took this from all in jest i think
function HRLR_UTIL.balanceScore(percent, card)
  -- actual score edits
  local bal_chips = math.floor(hand_chips * percent)
  local bal_mult = math.floor(mult * percent)

  hand_chips = mod_chips(hand_chips - bal_chips)
  mult = mod_mult(mult - bal_mult)

  local sum =  bal_chips + bal_mult
  hand_chips = mod_chips(math.floor(sum / 2) + hand_chips)
  mult = mod_mult(math.floor(sum / 2) + mult)

  -- visuals/sounds
  update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })

  G.E_MANAGER:add_event(Event({
    func = function()
      play_sound('gong', 0.94, 0.3)
      play_sound('gong', 0.94 * 1.5, 0.2)
      play_sound('tarot1', 1.5)
      ease_colour(G.C.UI_CHIPS, { 0.8, 0.45, 0.85, 1 })
      ease_colour(G.C.UI_MULT, { 0.8, 0.45, 0.85, 1 })

      if card then
        SMODS.calculate_effect({
          message = localize('k_balanced'),
          colour = { 0.8, 0.45, 0.85, 1 },
          instant = true
        }, card)
      end

      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blocking = false,
        blockable = false,
        delay = 4.3,
        func = function()
          ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
          ease_colour(G.C.UI_MULT, G.C.RED, 2)
          return true
        end
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blocking = false,
        blockable = false,
        no_delete = true,
        delay = 6.3,
        func = function()
          G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] =
              G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
          G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] =
              G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
          return true
        end
      }))

      return true
    end
  }))
  delay(0.6)
end
