require "bundler"
Bundler.require

require_relative "lib/game"

    #inizializer le jeu
    game = Game.new
    #comportement du jeu
    game.move