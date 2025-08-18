return {
  descriptions = {
    hrlr_dice = {
      c_hrlr_d4 = {
        name = 'd4',
        text = {
          "Upgrade level of",
          "the next {C:attention}#1#{} played",
          "{C:attention}poker hand(s){}"
        }
      },
      c_hrlr_d6 = {
        name = 'd6',
        text = {
          "Earn {X:mult,C:white}X#1#{} Mult",
          "for your next hand",
          "{C:attention}after{} scoring"
        }
      },
      c_hrlr_d8 = {
        name = 'd8',
        text = {
          "Earn {X:chips,C:white}X#1#{} Chips",
          "for your next hand",
          "{C:attention}after{} scoring"
        }
      },
      c_hrlr_d10 = {
        name = 'd10',
        text = {
          "Balance {C:purple}#1#{} of",
          "your next hand's",
          "{C:chips}Chips{} and {C:mult}Mult{}."
        }
      },
      c_hrlr_d12 = {
        name = 'd12',
        text = {
          "Earn {C:money}$#1#{} at",
          "the end of the",
          "next round"
        }
      },
      c_hrlr_d20 = {
        name = 'd20',
        text = {
          "Earn {C:mult}+#1#{} Mult",
          "for your next hand",
          "{C:attention}before{} scoring"
        }
      },
      c_hrlr_d100 = {
        name = 'd100',
        text = {
          "Earn {C:chips}+#1#{} Chips",
          "for your next hand",
          "{C:attention}before{} scoring"
        }
      }
    },
    Joker = {
      j_hrlr_bardic_inspiration = {
        name = "Bardic Inspiration",
        text = {
          "Create up to 2 random",
          "Dice before the {C:attention}final{}",
          "{C:attention}hand{} of the round",
          "{C:inactive}(Must have room){}"
        }
      },
      j_hrlr_dice_goblin = {
        name = "Dice Goblin",
        text = {
          "Add a free Dice Bag",
          "to every shop"
        }
      },
      j_hrlr_fuzzy_dice = {
        name = "Fuzzy Dice",
        text = {
          "Every time you roll a Die,",
          "this Joker gains the roll's",
          "value as {C:chips}+Chips{}",
          "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}"
        }
      },
      j_hrlr_luckstone = {
        name = "Luckstone",
        text = {
          "{X:default,C:white}X2{} to all Dice rolls",
          "{C:inactive}(Capped at the Die's maximum)"
        }
      }
    },
    Other = {
      undiscovered_hrlr_dice = {
        name = "Not Discovered",
        text = {
          "Purchase or use",
          "this card in an",
          "unseeded run to",
          "learn what it does"
        }
      },
      p_hrlr_dice_normal = {
        name = "Dice Bag",
        text = {
          "Choose {C:attention}#1#{} of",
          "up to {C:attention}#2#{} Dice"
        }
      },
      p_hrlr_dice_jumbo = {
        name = "Jumbo Dice Bag",
        text = {
          "Choose {C:attention}#1#{} of",
          "up to {C:attention}#2#{} Dice"
        }
      },
      p_hrlr_dice_mega = {
        name = "Mega Dice Bag",
        text = {
          "Choose {C:attention}#1#{} of",
          "up to {C:attention}#2#{} Dice"
        }
      }
    },
    Spectral = {
      c_hrlr_d2 = {
        name = 'd2',
        text = {
          "Flip a coin. Heads",
          "creates {C:tarot}The Soul{},",
          "Tails creates a {C:planet}Black Hole{}",
          "{C:inactive}(Must have room){}"
        }
      }
    },
    Voucher = {
      v_hrlr_advantage = {
        name = "Advantage",
        text = {
          "All Dice roll",
          "themselves twice, and",
          "pick the {C:attention}higher{} roll"
        }
      },
      v_hrlr_loaded_dice = {
        name = "Loaded Dice",
        text = {
          "If a Die rolls its",
          "{C:attention}minimum{} value, replace",
          "it with its {C:attention}maximum{} value"
        }
      }
    }
  },
  misc = {
    dictionary = {
      k_hrlr_dice = "Die",
      b_hrlr_dice_cards = "Dice",
      k_hrlr_dice_bag = "Dice Bag",

      k_plus_dice_1 = "+1 Die",
      k_plus_dice_2 = "+2 Dice",

      dice_goblin_trigger_ex = "Dice!"
    }
  }
}
