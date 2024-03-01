require 'dxruby'
require_relative "Ball"
require_relative "Blocks"
require_relative "Bgm"
# require_relative "Clear"
# require_relative "Item"

#バーの定義
bar_size = 100
bar_size_up = 0
bar_size_down = 0
bar_image = Image.new(bar_size, 20, C_WHITE)
bar_x = 40
bar_y = 460
bar = Sprite.new(bar_x, bar_y, bar_image)

#壁の定義
walls = [Sprite.new( 0, 0, Image.new( 20, 480, C_WHITE)),
        Sprite.new( 0, 0, Image.new( 640, 20, C_WHITE)),
        Sprite.new( 620, 0, Image.new( 20, 480, C_WHITE)),
        bar]

#ボールの定義
ball_respawn = Ball.new(350, 400)
ball = true
dx = 4
dy = -4

#ブロックの定義
blocks = []
blocks_blue = []
blocks_red = []
blocks_ex = []
Block.new(blocks)

#アイテムの定義
item = 0
item_spawn1 = 0
item_spawn2 = 0
item_spawn_rand1 = rand(21..460)
item_spawn_rand2 = rand(21..460)
item_drop1 = 0
item_drop2 = 0
item_speed = 3

item_image = Sprite.new( item_spawn_rand1, 21, Image.new( 20, 20, C_YELLOW))
item_image2 = Sprite.new( item_spawn_rand2, 21, Image.new( 20, 20, C_GREEN))


#音関係の定義
# bgm = Sound.new("bgm/ks019.wav")
# atk = Sound.new("bgm/hit.wav")
# ref = Sound.new("bgm/ref.wav")
# death = Sound.new("bgm/death.wav")
# se = Se.new

#デバッグ用
item_debug = 0

#ゲームの設定管理
game_main = true
game_restart = true
game_mane = true
game_resprn = true
win = false
life = 3
count = 0
hit = 0
crash = true

Window.loop do
    if game_restart == true

        #開始画面の表示
        Window.draw_font(100, 220, "ゲームを始めるにはenterを押して下さい\nゲームを終了するにはescapeを押して下さい\n\n残り残機は#{life}です", Font.default)
        if Input.key_push?(K_RETURN)
            ball = ball_respawn.ini_ball
            game_restart = false
            game_mane = false
            game_main = true
        elsif Input.key_push?(K_ESCAPE)
            break
        end
    elsif game_resprn == false

        #2回目以降の画面表示
        Window.draw_font(100, 220, "ゲームを始めるにはenterを押して下さい\nゲームを終了するにはescapeを押して下さい\n\n残り残機は#{life}です", Font.default)
        if Input.key_push?(K_RETURN)
            ball = ball_respawn.ini_ball
            game_restart = false
            game_main = true
            game_resprn = true
        elsif Input.key_push?(K_ESCAPE)
            break
        end
    elsif game_mane == false

        #難易度選択
        Window.draw_font(100, 200, "難易度の選択をして下さい\n\n1.easy\n2.normal\n3.hard",Font.default)
        if Input.key_push?(K_1)
            ball = ball_respawn.ini_ball
            game_main = true
            game_mane = true
            hit = 50
            dx = 4
            dy = -4
        elsif Input.key_push?(K_2)
            ball = ball_respawn.ini_ball
            Block_blue.new(blocks_blue)
            Block_blue.new(blocks_blue)
            game_main = true
            game_mane = true
            hit = 90
            dx = 6
            dy = -6
        elsif Input.key_push?(K_3)
            ball = ball_respawn.ini_ball
            game_main = true
            game_mane = true
            Block_blue.new(blocks_blue)
            Block_blue.new(blocks_blue)
            Block_red.new(blocks_red)
            Block_red.new(blocks_red)
            Block_red.new(blocks_red)
            hit = 150
            dx = 8
            dy = -8
        elsif Input.key_push?(K_9)
            ball = ball_respawn.ini_ball
            game_main = true
            game_mane = true
            Block_blue.new(blocks_blue)
            Block_blue.new(blocks_blue)
            Block_red.new(blocks_red)
            Block_red.new(blocks_red)
            Block_red.new(blocks_red)
            Block_ex.new(blocks_ex)
            hit = 150
            dx = 4
            dy = -4
        elsif Input.key_push?(K_ESCAPE)
            break
        end
    else
        if life > 0
            # se.bgm_play
            #ゲームのメインループ

            #デバッグ用
            Window.draw_font(80, 200, "確率#{item}\nヒット数#{hit}\nアイテム取得#{item_debug}\nバーサイズアップ#{bar_size_up}\n#{item_drop1}",Font.default)

            #メニュー画面に戻る
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

            #勝利判定
            if hit <= 0
                win = true
            end
            if win
                Window.draw_font(100, 200, "ゲームクリア！！\nおめでとう！！！\nもう一度ゲームをプレイするにはenterを押して下さい\nゲームを終了するにはescapeを押して下さい", Font.default)
                life = 3
                if Input.key_push?(K_RETURN)
                    game_restart = true
                    win = false
                    blocks.clear
                    blocks_blue.clear
                    blocks_red.clear
                    blocks_ex.clear
                    blocks_ex.clear
                    bar_image = Image.new(100, 20, C_WHITE)
                    # Clear.new
                    Block.new(blocks)
                    ball.y -= dy
                    dy = -dy
                elsif Input.key_push?(K_ESCAPE)
                    break
                end
            else
                if game_main

                    #壁衝突判定
                    if bar.x >20 && bar.x < 520
                        bar.x = Input.mouse_pos_x
                    elsif bar.x <= 20
                        if Input.mouse_pos_x >= 20
                            bar.x = 20
                            bar.x = Input.mouse_pos_x
                        end
                    elsif bar.x >= 520
                        if Input.mouse_pos_x <= 520
                            bar.x = 520
                            bar.x = Input.mouse_pos_x
                        end
                    end
                    
                    #当たり判定と反射、アイテムドロップ
                    blo_x = ball.check(blocks).first
                    blo_blue_x = ball.check(blocks_blue).first
                    blo_red_x = ball.check(blocks_red).first
                    blo_y = ball.check(blocks).first
                    blo_blue_y = ball.check(blocks_blue).first
                    blo_red_y = ball.check(blocks_red).first

                    # begin
                    # blo_x.x
                    # blo_x.y
                    # rescue
                    #     blo_x = 0
                    #     blo_y = 0
                    #     next
                    # end
                    
                    ball.x += dx
                    if ball === walls
                        ball.x -= dx
                        dx = -dx
                    end
                    if blo_x
                        blo_x.vanish
                        # ball.x -= dx
                        # dx = -dx
                        hit -= 1
                        item = rand(0..10)
                    end
                    if blo_blue_x
                        blo_blue_x.vanish
                        ball.x -= dx
                        dx = -dx
                        hit -= 1
                        item = rand(0..20)
                    end
                    if blo_red_x
                        blo_red_x.vanish
                        ball.x -= dx
                        dx = -dx
                        hit -= 1
                        item = rand(0..30)
                    end
                    ball.y += dy
                    if ball === walls
                        ball.y -= dy
                        dy = -dy
                    end
                    if blo_y
                        blo_y.vanish
                        ball.y -= dy
                        dy = -dy
                        item = rand(0..10)
                    end
                    if blo_blue_y
                        blo_blue_y.vanish
                        ball.y -= dy
                        dy = -dy
                        item = rand(0..20)
                    end
                    if blo_red_y
                        blo_red_y.vanish
                        ball.y -= dy
                        dy = -dy
                        item = rand(0..30)
                    end

                    #アイテム
                    if item == 1
                        item_spawn1 = item
                        item_drop1 += 1
                    end
                    if item == 2
                        item_spawn2 = item
                    end
                    if item_spawn1 == 1
                        item_spawn_rand1 = rand(21..460)
                        Sprite.draw(item_image)
                        item_image.y += item_speed
                    end
                    if item_spawn2 == 2
                        item_spawn_rand2 = rand(21..460)
                        Sprite.draw(item_image2)
                        item_image2.y += item_speed
                    end
                    if item_image.y > 500
                        item_spawn1 = 0
                    end
                    if item_image2.y > 500
                        item_spawn2 = 0
                    end
                    if item_image === walls
                        item_debug += 1
                        item_spawn1 = 0
                        item_image.y = 50
                        if bar_size < 200
                            bar_size_up = 1
                        end
                    end
                    if item_image2 === walls
                        item_debug += 1
                        item_spawn2 = 0
                        item_image2.y = 50
                        if bar_size > 50
                            bar_size_down = 1
                        end
                    end
                    if bar_size < 200
                        if bar_size_up > 0
                            bar_size += 50
                            bar_image = Image.new(bar_size, 20, C_WHITE)
                            bar.image = bar_image
                            bar_size_up -= 1
                        end
                    end
                    if bar_size > 50
                        if bar_size_down > 0
                            bar_size -= 50
                            bar_image = Image.new(bar_size, 20, C_WHITE)
                            bar.image = bar_image
                            bar_size_down -= 1
                        end
                    end
                    if item_drop1 > 0
                        item_drop1 -= 1
                    end

                    #ゲームオーバー判定
                    if ball.y > 480
                        game_main = false
                        ball.y -= dy
                        dy = -dy
                        life -= 1
                    end

                    #表示関係
                    ball.draw
                    Sprite.draw(walls)
                    Sprite.draw(blocks)
                    Sprite.draw(blocks_blue)
                    Sprite.draw(blocks_red)
                    Sprite.draw(blocks_ex)

                    #終了処理
                    break if Input.key_push?(K_ESCAPE)
                else
                    game_resprn = false
                end
            end
        else
            Window.draw_font(100, 220, "ゲームオーバー！\nもう一度プレイするにはenterを押して下さい\nゲームをやめるにはescapeを押して下さい", Font.default)
            if Input.key_push?(K_RETURN)
                blocks.clear
                blocks_blue.clear
                blocks_red.clear
                blocks_ex.clear
                bar_image = Image.new(100, 20, C_WHITE)
                bar.image = bar_image
                # Clear.new
                Block.new(blocks)
                game_restart = true
                life = 3
            elsif Input.key_push?(K_ESCAPE)
                break
            end
        end
    end
end

Window.close