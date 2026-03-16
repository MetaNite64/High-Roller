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
function HRLR_UTIL.rollDie(die, min_mod, max_mod)
  if not min_mod then local min_mod = 0 end
  if not max_mod then local max_mod = 0 end
  local rolls = {}
  rolls[1] = pseudorandom('roll_die', 1 + min_mod, die.ability.extra.sides + max_mod)
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 1.3,
    func = function()
      die:juice_up(0.8, 0.5)
      die.ability.extra.value = rolls[1]
      local percent = pseudorandom("roll_sfx") * 0.2
      play_sound('hrlr_roll', 0.9 + percent, 1)
      return true
    end
  }))
  local modified = {}
  SMODS.calculate_context({
    hrlr_dice_mod = true,
    hrlr_die = die,
    hrlr_die_sides = die.ability.extra.sides,
    hrlr_roll_value = rolls[1]
  }, modified)
  delay(1.5)
  local roll_index = 1
  for _, v in ipairs(modified) do
    for _, w in pairs(v) do
      rolls[#rolls + 1] = w.hrlr_roll_value
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 1.1,
        func = function()
          roll_index = roll_index + 1
          die:juice_up(0.8, 0.5)
          die.ability.extra.value = rolls[roll_index]
          local percent = pseudorandom("roll_mod_sfx") * 0.2
          play_sound('hrlr_dice_mod', 0.9 + percent, 0.7)
          return true
        end
      }))
      SMODS.trigger_effects({ v }, w.card)
    end
  end
  return rolls[#rolls]
end

-- standard Use behavior for dice
function HRLR_UTIL.useDie(card)
  -- check for boundary modifiers
  local min_mod = 0
  local max_mod = 0
  local bound_mods = {}
  SMODS.calculate_context({
    hrlr_modify_bounds = true,
    hrlr_die = card,
    hrlr_die_sides = card.ability.extra.sides
  }, bound_mods)
  for _, v in ipairs(bound_mods) do
    for _, w in pairs(v) do
      min_mod = min_mod + (w.hrlr_min_mod or 0)
      max_mod = max_mod + (w.hrlr_max_mod or 0)
    end
  end

  -- spotlight card, base roll
  draw_card(G.consumeables, G.play, 1, 'up', true, card, nil, mute)
  local current_roll = HRLR_UTIL.rollDie(card, min_mod, max_mod)
  card.ability.extra.rolled = true

  -- check for rerolls
  local reroll_effects = {}
  SMODS.calculate_context({
    hrlr_add_rerolls = true,
    hrlr_die = card,
    hrlr_roll_value = current_roll
  }, reroll_effects)

  -- do rerolls
  for _, v in ipairs(reroll_effects) do
    for _, w in pairs(v) do
      if w.hrlr_rerolls then
        local reroll_table = { current_roll }
        for i = 1, w.hrlr_rerolls do table.insert(reroll_table, HRLR_UTIL.rollDie(card, min_mod, max_mod)) end
        if w.hrlr_reroll_determiner and type(w.hrlr_reroll_determiner) == "function" then
          current_roll = w.hrlr_reroll_determiner(reroll_table)
        else  -- by default, pick the max roll
          current_roll = math.max(unpack(reroll_table))
        end
      end
    end
  end

  -- calculate post_roll context
  SMODS.calculate_context({
    hrlr_post_roll = true,
    hrlr_die = card,
    hrlr_roll_value = current_roll
  })

  return current_roll
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

-- mod calculate, purely for unlocking the dude
SMODS.current_mod.calculate = function(self, context)
  if context.hrlr_post_roll then
    if context.hrlr_die.config.center.key == "c_hrlr_d20" and context.hrlr_roll_value == 20 then
      G.E_MANAGER:add_event(Event({
        trigger = "after",
        func = function()
          unlock_card(G.P_CENTERS["v_hrlr_loaded_dice"])
          return true
        end
      }))
    end
  end
end
