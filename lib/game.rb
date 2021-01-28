require "bundler"
Bundler.require

  #permet d'inizializer le jeu, les joueurs avec certaine conditions
class Game
      #condition de victoire en fonction de array @board
    WINNING_COMBOS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2],
    ]

        #création des players à chaque début de partie
      def initialize
       @players = Players.new
      end
        #cette méthode fait le lien avec toutes les autres methodes pour pouvoir éxecuter les régles du jeu correctement
      def move
        @end = false
        @gameboard = Board.new
        @turn = 1
        while @turn<10
          if @turn % 2 != 0
              turn_sequence(@players.player1, "X")
          elsif @turn % 2 == 0
              turn_sequence(@players.player2, "O")
          end
        end
      end
        #méthode pour vérifier si le joueur rentre bien un chiffre compris entre 0 et 8 et permet de compter les tour pour mettre fain à la partie
      def turn_sequence (player, symbol)
        puts "#{player}(#{symbol}) choisis t'as position"
        @player_move = gets.chomp.to_i
        if (0..8).include?(@player_move) && @gameboard.board[@player_move] == " " && @end == false
          @turn += 1
          @gameboard.board_update(@player_move, symbol)
          win_check
          check_null
        else
          puts "entre un numbre entre 0 et 8\n"
        end
      end
        #méthode pour vérrifier si l'array @board est compatible avec les WINNING_COMBOS (combinaison gagnante)
      def win_check
        WINNING_COMBOS.each do |win_check|
          if (@gameboard.board[win_check[0]] == @gameboard.board[win_check[1]] && 
            @gameboard.board[win_check[1]] == @gameboard.board[win_check[2]]) &&
            @gameboard.board[win_check[0]] != " "
            if @gameboard.board[win_check[0]] == "X"
              puts "#{@players.player1} WINS"
              @turn = 10
              @end = true
              play_again?
            elsif @gameboard.board[win_check[0]] == "O"
              puts "#{@players.player2} WINS"
              @turn = 10
              @end = true
              play_again?
            end
          end
        end
      end
        #méthode pour déterminer si c'est un match nul  
      def check_null
        if @turn == 10 && @end == false
          puts "EGALITE"
          play_again?
        end
      end
        #méthode pour savoir si le jour veux continuer
      def play_again?
        puts "Continuer? (Y/N)"
          response = ""
          while response != "Y" || response != "N"
            response = gets.chomp.upcase
              if response == "Y"
                newgame = Game.new
                newgame.move  
              elsif response == "N"
                break
              else 
                puts "Rentre (Y/N) =)"
              end
          end
      end
    end
        #class qui permet de nommer les deux joueurs
    class Players
      attr_reader :player1, :player2
      
      def initialize
        puts "Player 1, quelle est ton nom"
        @player1 = gets.chomp
        puts "#{@player1} is X"
        puts "Player 2, quelle est ton nom"
        @player2 = gets.chomp
        puts "#{@player2} is O"
      end
    
    end
        #class pour afficher le plateau et pouvoir le modifier
    class Board
      attr_reader :board
          
      def initialize
        puts "Quand ça serra ton tour utilise les chiffres pour pouvoir te positioner:"
        puts "0 | 1 | 2"
        puts "---------"
        puts "3 | 4 | 5"
        puts "---------"
        puts "6 | 7 | 8"
        @board = [" "," "," "," "," "," "," "," "," "]
      end
        #méthode pour remplacer les emplacement de l'array @board par "X" ou "O"  
      def board_update(position, symbol)
        @board[position] = symbol
        BoardCase(@board)
      end
        #méthode pour afficher le plateau
      def BoardCase (board)
        puts "#{board[0]} | #{board[1]} | #{board[2]}"
        puts "---------"
        puts "#{board[3]} | #{board[4]} | #{board[5]}"
        puts "---------"
        puts "#{board[6]} | #{board[7]} | #{board[8]}"
      end
    end


    # annexe @end sert à mettre fin à la partie
    # pour BoardCase on utilise les cellules de l'array que l'on affiche donc on peux "dessiner" ce qu'on l'on veux autour de cette cellule et faire un update de la cellule via une méthode pour remplacer un élement du tableau