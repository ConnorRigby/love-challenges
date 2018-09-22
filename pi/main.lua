function love.load()
    love.window.setMode(400, 400, {resizable=false});
    love.graphics.setBackgroundColor(0,0,0);
    width = love.graphics.getWidth();
    height = love.graphics.getHeight();
    r = 200;
    inPoints = {};
    outPoints = {};
    recordPi = 0;
    total = 0;
    circle = 0;
end

function love.draw()
    love.graphics.setColor(0.5,0.5,0.5);
    love.graphics.setLineWidth(8)
    love.graphics.rectangle("line", 0, 0, r*2, r*2);
    love.graphics.translate(width/2, height/2);
    love.graphics.ellipse("line", 0, 0, 200, 200);

    for i=0, 100 do
        local x = love.math.random(-r, r);
        local y = love.math.random(-r, r);
        local d = dist(0, 0, x, y);
        if ( d < r*r ) then
            circle = circle + 1;
            table.insert(inPoints, {x, y});
            love.graphics.setColor( 0.2, 1, 0.317 );
            love.graphics.points(inPoints);
            love.graphics.setColor( 1, 1, 1 );
        else
            table.insert(outPoints, {x, y});
            love.graphics.points(outPoints);
        end
        total = total + 1;

        pi = 4 * (circle / total);
        recordDiff = math.abs(math.pi - recordPi);
        diff = math.abs(math.pi - pi);
        if (diff < recordDiff) then
            recordDiff = diff;
            recordPi = pi;
        end
        love.graphics.print(pi, 300, 300);
        love.graphics.print(recordPi, 300, 300);
    end
    

    print("pi      ", pi);
    print("recordPi", recordPi);
end

function love.update() 
end

function dist( x1, y1, x2, y2 )
    local dx = x1 - x2
    local dy = y1 - y2
    return  dx * dx + dy * dy 
  end