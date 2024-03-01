require 'dxruby'

#バーの定義
bar = Sprite.new(0,460,Image.new(100, 20, C_WHITE))

#壁の定義、ボールの定義
walls = [Sprite.new( 0, 0, Image.new( 20, 480, C_WHITE)),
        Sprite.new( 0, 0, Image.new( 640, 20, C_WHITE)),
        Sprite.new( 620, 0, Image.new( 20, 480, C_WHITE)),
        bar]

class Ball < Sprite
    def initialize(ball_x, ball_y)
        @ball_x = ball_x
        @ball_y = ball_y
    end        
    def ini_ball
        Sprite.new( @ball_x, @ball_y, Image.new( 20, 20).circle_fill( 10, 10, 10, C_WHITE))
    end
end

ball_respawn = Ball.new(300, 400)
ball = true

dx = 4
dy = -4

#ブロックの定義
image = Image.new( 58, 18, C_WHITE)
blocks = []
5.times do |y|
    10.times do |x|
        blocks << Sprite.new(21 + 60 * x,21 + 20 * y, image)
    end
end

#ゲームの設定管理
game_main = true
game_restart = true
count = 0

Window.loop do
    if game_restart == true

        #メニュー画面の表示
        Window.draw_font(100, 220, "ゲームを始めるにはenterを押して下さい\nゲームを終了するにはescapeを押して下さい", Font.default)
        if Input.key_push?(K_RETURN)
            ball = ball_respawn.ini_ball
            game_restart = false
            game_main = true
        elsif Input.key_push?(K_ESCAPE)
            break
        end

    else
        #ゲームのメインループ
        if game_main
            bar.x = Input.mouse_pos_x
            Sprite.draw(walls)
            ball.x += dx
            if ball === walls
                ball.x -= dx
                dx = -dx
            end
            col_x = ball.check(blocks).first
            if col_x
                col_x.vanish
                ball.x -= dx
                dx = -dx
            end
            ball.y += dy
            if ball === walls
                ball.y -= dy
                dy = -dy
            end
            col_y = ball.check(blocks).first
            if col_y
                col_y.vanish
                ball.y -= dy
                dy = -dy
            end
            #ゲームオーバー判定

            if ball.y > 480
                game_main = false
                ball.y -= dy
                dy = -dy
            end

            ball.draw
            Sprite.draw(blocks)
            #終了処理

            break if Input.key_push?(K_ESCAPE)

        else
            game_restart = true
        end
    end
end

Window.close