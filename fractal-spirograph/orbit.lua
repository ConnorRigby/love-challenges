function Orbit(x_, y_, r_, n_, p)
    print("creating new orbit")
    local k = -4;
    local self = {};
    self.x = x_;
    self.y = y_;
    self.r = r_;
    self.n = n_;
    self.speed = math.rad(math.pow(k, self.n-1));
    self.angle = 0;
    self.parent = p;
    self.child = nil;

    function self.addChild()
        local newr = self.r / 3;
        local newx = self.x + self.r + newr;
        local newy = self.y;
        self.child = Orbit(newx, newy, newr, self.n+1, self);
        return self.child;    
    end

    function self.show()
        print("show", "x", self.x, "y", self.y)
        love.graphics.ellipse("line", self.x, self.y, self.r, self.r);
    end

    function self.update()
        if self.parent then
            local rsum = self.r + self.parent.getr()
            self.angle = self.angle + self.speed;
            self.x = self.parent.getx() + rsum * math.cos(self.angle);
            self.y = self.parent.gety() + rsum * math.sin(self.angle);
        end
    end

    function self.getChild()
        return self.child;
    end

    function self.getx()
        return self.x;
    end

    function self.gety()
        return self.y;
    end

    function self.getr()
        return self.r;
    end

    return self;
end