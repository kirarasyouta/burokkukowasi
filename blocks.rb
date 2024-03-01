class Block < Sprite
    def initialize(blocks)
        image = Image.new( 58, 18, C_WHITE)
        5.times do |y|
            10.times do |x|
                blocks << Sprite.new(21 + 60 * x,21 + 20 * y, image)
            end
        end
    end
end
class Block_blue < Sprite
    def initialize(blocks_blue)
        image_level1 = Image.new( 58, 18, C_BLUE)
        2.times do |y|
            10.times do |x|
                blocks_blue << Sprite.new(21 + 60 * x,121 +  20* y, image_level1)
            end
        end
    end
end
class Block_red < Sprite
    def initialize(blocks_red)
        image_level2 = Image.new( 58, 18, C_RED)
        2.times do |y|
            10.times do |x|
                blocks_red << Sprite.new(21 + 60 * x,161 +  20* y, image_level2)
            end
        end
    end
end
class Block_ex < Sprite
    def initialize(blocks_ex)
        image_level9 = Image.new( 600, 220, C_GREEN)
        1.times do |y|
            1.times do |x|
                blocks_ex << Sprite.new(20 + 60 * x,220 +  20* y, image_level9)
            end
        end
    end
end