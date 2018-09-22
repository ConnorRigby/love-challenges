require "./orbit"

function love.load()
    love.window.setMode(600, 600, {resizable=false});
    love.graphics.setBackgroundColor(0.568, 0.568, 0.568)
    width = love.graphics.getWidth();
    height = love.graphics.getHeight();
    sun = Orbit(300, 300, 150, 0);
    local next = sun;
    local i;
    for i=0, 20 do
        next = next.addChild();
    end
    last = next;
    path = {};
end

function love.draw()

    local next = sun;
    while next do
        next.update()
        next.show();
        next = next.getChild();
    end

    local poly = {};
    table.insert(path, last.getx());
    table.insert(path, last.gety());
    local s = table.getn(path);
    print("s", s);
    for i = 0, s do
        print("poly ", path[i])
        table.insert(poly, path[i]);
    end
    if table.getn(poly) >= 6  then
        love.graphics.polygon('line', poly)
    end
end