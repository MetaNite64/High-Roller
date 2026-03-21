SMODS.Booster {
  key = 'dice_jumbo',
  atlas = 'boosters',
  pos = { x = 2, y = 0 },
  pixel_size = { h = 74 },
  config = {
    extra = 4,
    choose = 1
  },
  group_key = 'k_hrlr_dice_bag',
  kind = 'hrlr_dice',
  select_card = 'consumeables',
  cost = 6,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, HRLR_UTIL.colors.DICE_BG)
    ease_background_colour { new_colour = HRLR_UTIL.colors.DICE_BG, special_colour = G.C.BLACK, contrast = 2 }
  end,

  create_card = function(self, card, i)
    return {
      set = 'hrlr_dice',
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true
    }
  end
}
