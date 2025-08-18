SMODS.Joker {
  key = "luckstone",
  atlas = "placeholder",
  pos = { x = 0, y = 0 },
  rarity = 3,
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.hrlr_dice_mod then
      local sides = context.hrlr_die_sides
      local new_roll = math.min(context.hrlr_roll_value * 2, sides)
      return {
        message = "Lucky!",
        colour = G.C.GREEN,
        hrlr_roll_value = new_roll
      }
    end
  end
}
