SMODS.Voucher {
  key = 'loaded_dice',
  atlas = 'placeholder',
  pos = { x = 0, y = 0 },
  requires = { 'v_hrlr_advantage' },

  calculate = function(self, card, context)
    if context.hrlr_dice_mod then
      local die = context.hrlr_other_die
      if context.hrlr_roll_value == 1 then
        return { hrlr_roll_value = die.ability.extra.sides }
      end
    end
  end
}
