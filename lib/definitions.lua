HRLR_UTIL = {}

-- ## OBJECT TABLES ##
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

-- ## ATLASES ##
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

-- jokers atlas
SMODS.Atlas {
  key = "jokers",
  path = "jokers.png",
  px = 71, py = 95
}

-- ## SFX ##
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
