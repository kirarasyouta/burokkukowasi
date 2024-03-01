class Menu
    def initialize
        if Input.key_push?(K_M)
            game_restart = true
            life = 3
            blocks.clear
            blocks_blue.clear
            blocks_red.clear
            blocks_ex.clear
            # Clear.new(crash)
            Block.new(blocks)
            ball.y -= dy
            dy = -dy
        end
    end
end