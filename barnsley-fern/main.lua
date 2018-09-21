-- https://en.wikipedia.org/wiki/Barnsley_fern
function love.load()
    love.window.setMode( 600, 600, {resizable=false} );
    love.graphics.setPointSize(1);
    width = love.graphics.getWidth( );
    height = love.graphics.getHeight( );
    all_points = {};
    x = 0;
    y = 0;
end

function love.draw()
    -- Draw 300 points per frame
    for i=0, 300 do
        local wr = love.math.random(100)
        local hr = love.math.random(100)
        local px = map(x, -4, 4, 0, width);
        local py = map(y, 0, 10, height, 0);
        table.insert(all_points, {px, py, wr * 0.01, hr * 0.01, 1});
        local nextX, nextY = nextPoint(x, y);
        x = nextX; 
        y = nextY;
    end
    love.graphics.points(all_points);
end

function nextPoint(lastX, lastY)
    local r = love.math.random(100);
    if r<=1 then
        -- 1
        local nextX = 0;
        local nextY = 0.16 * lastY;
        return nextX, nextY;
    elseif r<86 then  
        -- 2
        local nextX =  0.85 * lastX + 0.04 * lastY;
        local nextY = -0.04 * lastX + 0.85 * lastY + 1.6;
        return nextX, nextY;
    elseif r<93 then
        -- 3
        local nextX = 0.20 * lastX  + -0.26 * lastY;
        local nextY = 0.23 * lastX + 0.22  * lastY + 1.6;
        return nextX, nextY;
    else
        -- 4
        local nextX = -0.15 * lastX + 0.28 * lastY;
        local nextY =  0.26 * lastX + 0.24 * lastY + 0.44;
        return nextX, nextY;
    end
end

function map(s, a1, a2, b1, b2)
    return b1 + (s-a1)*(b2-b1)/(a2-a1)
end