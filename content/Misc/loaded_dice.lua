SMODS.Voucher {
  key = 'loaded_dice',
  atlas = 'placeholder',
  pos = { x = 0, y = 0 },
  requires = { 'v_hrlr_advantage' },

  calculate = function(self, card, context)
    if context.hrlr_modify_bounds then
        return { hrlr_min_mod = math.floor(0.5 * context.hrlr_die_sides) }
    end
  end
}
