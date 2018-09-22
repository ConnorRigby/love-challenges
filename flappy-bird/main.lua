require "./bird"
require "./pipe"

function love.load()
    love.window.setMode(400, 600, {resizable=false});
    love.graphics.setBackgroundColor(0,0,0);
    width = love.graphics.getWidth();
    height = love.graphics.getHeight();

    pipes = {};
    frames = 0;
    bird = Bird();
    table.insert(pipes, Pipe());
end

function love.draw()
    bird.update();
    bird.show();
    for i = #pipes, 1, -1 do
        pipes[i].show();
    end

    frames = frames + 1;
    if frames == 100 then
        frames = 0;
        table.insert(pipes, Pipe());
    end  
end

function love.update()
    bird.update();
    for i = #pipes, 1, -1 do
        pipes[i].update();
        if (pipes[i].hits(bird)) then
            print("hit!");
        end
        
        if (pipes[i].offScreen()) then
            table.remove(pipes, i);
        end
    end
end

function love.keypressed(key, scancode, isrepeat) 
    if key == "space" then
        bird.up()
    end
end