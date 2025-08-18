SMODS.Booster {
  key = 'dice_normal_1',
  atlas = 'placeholder',
  pos = { x = 0, y = 0 },
  config = {
    extra = 2,
    choose = 1
  },
  group_key = 'k_hrlr_dice_bag',
  kind = 'hrlr_dice',
  select_card = 'consumeables',
  cost = 4,

  loc_vars = function(self, info_queue, card)
    local cfg = (card and card.ability) or self.config
    return {
      vars = { cfg.choose, cfg.extra },
      key = self.key:sub(1, -3)
    }
  end,

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
