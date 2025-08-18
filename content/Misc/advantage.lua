SMODS.Voucher {
  key = 'advantage',
  atlas = 'placeholder',
  pos = { x = 0, y = 0 },

  calculate = function(self, card, context)
    if context.hrlr_add_rerolls then
      return {
        hrlr_rerolls = 1
      }
    end
  end
}
