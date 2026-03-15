return {
  descriptions = {
    Back = {
      b_hrlr_gamblers = {
        name = "Gambler's Deck",
        text = {
          "{X:gold,C:white}X#1#{} shop costs",
          "",
          "After defeating each",
          "{C:attention}Blind{}, gain up to",
          "{C:attention}#2#{} random {C:attention}Dice{}",
          "{C:inactive}(Must have room)"
        }
      }
    },
    hrlr_dice = {
      c_hrlr_d4 = {
        name = 'd4',
        text = {
          "Give {C:attention}#1#{} temporary",
          "level(s) to the next",
          "played {C:attention}poker hand{}"
        }
      },
      c_hrlr_d6 = {
        name = 'd6',
        text = {
          "Earn {X:mult,C:white}X#1#{} Mult",
          "for the next hand",
          "{C:attention}after{} scoring"
        }
      },
      c_hrlr_d8 = {
        name = 'd8',
        text = {
          "Earn {X:chips,C:white}X#1#{} Chips",
          "for the next hand",
          "{C:attention}after{} scoring"
        }
      },
      c_hrlr_d10 = {
        name = 'd10',
        text = {
          "Balance {C:purple}#1#{} of",
          "the next hand's",
          "{C:chips}Chips{} and {C:mult}Mult{}"
        }
      },
      c_hrlr_d12 = {
        name = 'd12',
        text = {
          "Earn {C:money}$#1#{}",
          "immediately"
        }
      },
      c_hrlr_d20 = {
        name = 'd20',
        text = {
          "Earn {C:mult}+#1#{} Mult",
          "for the next hand",
          "{C:attention}before{} scoring"
        }
      },
      c_hrlr_d100 = {
        name = 'd100',
        text = {
          "Earn {C:chips}+#1#{} Chips",
          "for the next hand",
          "{C:attention}before{} scoring"
        }
      }
    },
    Joker = {
      j_hrlr_bardic_inspiration = {
        name = "Bardic Inspiration",
        text = {
          "Create up to 2 random",
          "{C:attention}Dice{} before the {C:attention}final{}",
          "{C:attention}hand{} of the round",
          "{C:inactive}(Must have room){}"
        }
      },
      j_hrlr_dice_goblin = {
        name = "Dice Goblin",
        text = {
          "Add a free {C:attention}Dice Bag{}",
          "to every shop"
        }
      },
      j_hrlr_fuzzy_dice = {
        name = "Fuzzy Dice",
        text = {
          "Every time you roll a {C:attention}Die{},",
          "this Joker gains the roll's",
          "value as {C:chips}+Chips{}",
          "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}"
        }
      },
      j_hrlr_luckstone = {
        name = "Luckstone",
        text = {
          "{X:default,C:white}X2{} to all {C:attention}Dice{} rolls",
          "{C:inactive}(Capped at the {C:attention}Die's{C:inactive} maximum)"
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
          "up to {C:attention}#2# Dice{}"
        }
      },
      p_hrlr_dice_jumbo = {
        name = "Jumbo Dice Bag",
        text = {
          "Choose {C:attention}#1#{} of",
          "up to {C:attention}#2# Dice{}"
        }
      },
      p_hrlr_dice_mega = {
        name = "Mega Dice Bag",
        text = {
          "Choose {C:attention}#1#{} of",
          "up to {C:attention}#2# Dice{}"
        }
      }
    },
    Spectral = {
      c_hrlr_d2 = {
        name = 'd2',
        text = {
          {
            "This coin can be",
            "flipped once per round",
            "{C:inactive}(#1#){}"
          },
          {
            "{C:attention}Heads{}",
            "This card gains {C:attention}+1{}",
            "to all {C:attention}Die{} rolls",
            "{C:inactive}(Currently +#2#)"
          },
          {
            "{C:attention}Tails{}",
            "The next {C:attention}Die{} roll is",
            "guaranteed to be the",
            "{C:attention}maximum value{}.",
            "{C:attention}Reset{} this card to +0",
            "{C:inactive}(#3#){}"
          }
        }
      }
    },
    Voucher = {
      v_hrlr_advantage = {
        name = "Advantage",
        text = {
          "All {C:attention}Dice{} roll",
          "themselves twice, and",
          "pick the {C:attention}higher{} roll"
        }
      },
      v_hrlr_loaded_dice = {
        name = "Loaded Dice",
        text = {
          "{C:attention}Dice{} always roll in the",
          "{C:attention}upper half{} of their range"
        },
        unlock = {
          "Roll a {C:attention}20",
          "on a {C:attention}d20"
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
      k_hrlr_inactive = "Inactive...",
      k_hrlr_active_ex = "Active!",

      k_hrlr_dice_ex = "Dice!",
      k_hrlr_lucky_ex = "Lucky!",
      k_hrlr_bonus_ex = "Bonus!",
      k_hrlr_crit_ex = "Crit!"
    }
  }
}
