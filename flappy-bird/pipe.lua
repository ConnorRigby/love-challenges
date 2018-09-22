function Pipe()
    local self = {};
    self.top = love.math.random(height/2);
    self.bottom = love.math.random(height/2);
    self.x = width;
    self.w = 20;
    self.speed = 1;
    self.highlight = false;

    function self.show()
        if self.highlight then
            love.graphics.setColor(0.7, 0.5, 0.1)
        else
            love.graphics.setColor(0.5,0.5,0.5)
        end
        love.graphics.rectangle("fill", self.x, 0, self.w, self.top);
        love.graphics.rectangle("fill", self.x, height-self.bottom, self.w, self.bottom);
    end

    function self.update()
        self.x = self.x - self.speed;
    end

    function self.offScreen()
        return self.x < 0;
    end

    function self.hits(bird)
        if ((bird.y+bird.r) < self.top or (bird.y+bird.r) > height - self.bottom) then
            self.highlight = (bird.x+bird.r) > self.x and (bird.x+bird.r) < self.x + self.w;
        else
            self.highlight = false;
        end

        return self.highlight;
    end

    return self;
end