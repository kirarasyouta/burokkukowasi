class Ball < Sprite
    def initialize(ball_x, ball_y)
        @ball_x = ball_x
        @ball_y = ball_y
    end        
    def ini_ball
        Sprite.new( @ball_x, @ball_y, Image.new( 20, 20).circle_fill( 10, 10, 10, C_WHITE))
    end
end