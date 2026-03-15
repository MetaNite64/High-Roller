SMODS.Voucher {
  key = 'advantage',
  atlas = 'misc',
  pos = { x = 3, y = 0 },

  calculate = function(self, card, context)
    if context.hrlr_add_rerolls then
      return {
        hrlr_rerolls = 1
      }
    end
  end
}
