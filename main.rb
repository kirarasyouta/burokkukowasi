require 'dxruby'

#バーの定義
bar = Sprite.new(0,460,Image.new(100, 20, C_WHITE))
#壁の定義、ボールの定義
walls = [Sprite.new( 0, 0, Image.new( 20, 480, C_WHITE)),
        Sprite.new( 0, 0, Image.new( 640, 20, C_WHITE)),
        Sprite.new( 620, 0, Image.new( 20, 480, C_WHITE)),
        bar]
ball = Sprite.new( 300, 400, Image.new( 20, 20).circle_fill( 10, 10, 10, C_WHITE))
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

Window.loop do
    if game_restart
        Window.draw_font(100, 220, "ゲームを始めるにはenterを押して下さい", Font.default)
    end
    break if Input.key_push?(K_RETURN)
end
Window.loop do
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

    col_y =ball.check(blocks).first
    if col_y
        col_y.vanish
        ball.y -= dy
        dy = -dy
    end

    if ball.y > 480
        game_main = false
    end

    

    ball.draw

    Sprite.draw(blocks)
    #終了処理
    break if Input.key_push?(K_ESCAPE)
else
    break
end
end

Window.close