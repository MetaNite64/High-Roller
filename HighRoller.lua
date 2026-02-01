--[[
################### HIGH ROLLER ###################
################## by metanite64 ##################
#  A mod about dice, a brand new consumable type. #
#      7 Dice, one associated Spectral card,      #
#      1 voucher set, 1 deck, and 4 Jokers.       #
###################################################
--]]

assert(SMODS.load_file("lib/definitions.lua"))()
assert(SMODS.load_file("lib/functions.lua"))()
assert(SMODS.load_file("lib/dice.lua"))()


HRLR_UTIL.loadItems(HRLR_UTIL.enabled_dice, "content/Dice")
HRLR_UTIL.loadItems(HRLR_UTIL.enabled_bags, "content/Boosters")
HRLR_UTIL.loadItems(HRLR_UTIL.enabled_jokers, "content/Jokers")
HRLR_UTIL.loadItems(HRLR_UTIL.enabled_misc, "content/Misc")
