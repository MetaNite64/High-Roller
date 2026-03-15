SMODS.Voucher {
  key = 'loaded_dice',
  atlas = 'misc',
  pos = { x = 4, y = 0 },
  requires = { 'v_hrlr_advantage' },
  unlocked = false,

  calculate = function(self, card, context)
    if context.hrlr_modify_bounds then
        return { hrlr_min_mod = math.floor(0.5 * context.hrlr_die_sides) }
    end
  end,

  check_for_unlock = function(self, args)
    return false
  end
}
