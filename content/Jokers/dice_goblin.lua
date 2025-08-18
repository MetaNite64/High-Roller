SMODS.Joker {
  key = "dice_goblin",
  atlas = "placeholder",
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.starting_shop then
      G.E_MANAGER:add_event(Event({
        func = function()
          local key = 'p_hrlr_dice_normal_' .. pseudorandom('dice_goblin', 1, 2)
          local booster = SMODS.add_booster_to_shop(key)
          booster.ability.couponed = true
          booster:set_cost()
          return true
        end
      }))

      return {
        message = localize('dice_goblin_trigger_ex'),
        colour = G.C.BLACK
      }
    end
  end
}
