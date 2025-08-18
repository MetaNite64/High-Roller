SMODS.Voucher {
  key = 'loaded_dice',
  atlas = 'placeholder',
  pos = { x = 0, y = 0 },
  requires = { 'v_hrlr_advantage' },

  calculate = function(self, card, context)
    if context.hrlr_dice_mod then
      local sides = context.hrlr_die_sides
      if context.hrlr_roll_value == 1 then
        return { hrlr_roll_value = sides }
      end
    end
  end
}
