SMODS.Back {
  key = "gamblers",
  atlas = "misc",
  pos = { x = 0, y = 0 },
  config = { extra = {
    price_hike = 1.5,
    dice_max = 2
  } },

  loc_vars = function(self, info_queue, back)
    return { vars = {
      self.config.extra.price_hike,
      self.config.extra.dice_max
    } }
  end,

  apply = function(self, back)
    G.GAME.hrlr_price_hike = self.config.extra.price_hike
  end,

  calculate = function(self, back, context)
    if context.round_eval then
      for i = 1, 2 do
        G.E_MANAGER:add_event(Event({
          func = function()
            SMODS.add_card { set = "hrlr_dice", key_append = "b_hrlr_gamblers", edition = "e_negative" }
            return true
          end
        }))
      end
    end
  end
}

-- Card.set_cost: hook to multiply in Gambler's Deck price hike
local set_cost_ref = Card.set_cost
function Card:set_cost()
  set_cost_ref(self)
  self.cost = math.floor(self.cost * (G.GAME.hrlr_price_hike or 1) + 0.5)
end
