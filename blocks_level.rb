class Block_blue < Sprite
    def ini_block(blocks_blue)
        image_level1 = Image.new( 58, 18, C_BLUE)
        2.times do |y|
            10.times do |x|
                blocks_blue << Sprite.new(21 + 60 * x,81 +  20* y, image_level1)
            end
        end
    end
end