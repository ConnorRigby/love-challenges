function Bird()
    local self = {};
    self.y = height/2;
    self.x = 64;
    self.gravity = 0.5;
    self.lift = -30;
    self.velocity = 0;
    self.r = 16;
    
    function self.show()
        love.graphics.setColor(1, 1, 1)
        love.graphics.ellipse("fill", self.x, self.y, self.r, self.r);
    end

    function self.update()
        self.velocity = self.velocity + self.gravity;
        self.velocity = self.velocity * 0.9;
        self.y = self.y + self.velocity;

        if (self.y > height) then
            self.y = height;
            self.velocity = 0;
        end

        if (self.y < 0) then
            self.y = 0;
            self.velocity = 0;
        end
    end

    function self.up()
        self.velocity = self.velocity + self.lift;
    end

    return self;
end