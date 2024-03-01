class Item
    def initialize
        if item == 1
            item_spawn = item
            item_drop = false
        end
        if item_spawn == 1
            Sprite.draw(item_image)
            item_image.y += 5
        end
        if item_image.y > 250
            item_spawn = 0
            item_image.y = 0
        end

        if item == 2
            item_spawn = item
            item_drop = false
        end
        if item_spawn == 2
            Sprite.draw(item_image2)
            item_image2.y += 5
        end
        if item_image2.y > 250
            item_spawn = 0
            item_image2.y = 0
        end
    end
end