function love.load()
    love.window.setFullscreen( true, "desktop" )
    love.graphics.setBackgroundColor(0,0,0);
    width = love.graphics.getWidth();
    height = love.graphics.getHeight();

    values = {};
    for i=0,width do
        values[i] = love.math.random(height);
    end
    i = 0;
    j = 0;
    started = false;
end

function love.draw()
    if (started) then
        if (i < width) then
            for j=0, width-i-1 do
                local a = values[j];
                local b = values[j + 1];
                if (a < b) then
                    swap(values, j, j+1);
                end
            end
        else
            print("finished");
            return;
        end
        
        local a = values[j];
        local b = values[j+1];
        if (a > b) then
            swap(values, j, j+1);
        end
    end

    for i=0,width do
        love.graphics.line(i, height, i, height - values[i]);
    end
end

function love.keypressed(key)
    if (key == "space") then
        started = not started;
    end

    if (key == "a") then
        os.exit();
    end

    if (not started) then
        if (key == "s") then
            if (i < width) then
                for j=0, width-i-1 do
                    local a = values[j];
                    local b = values[j + 1];
                    if (a < b) then
                        swap(values, j, j+1);
                    end
                end
            else
                print("finished");
                return;
            end
            
            local a = values[j];
            local b = values[j+1];
            if (a > b) then
                swap(values, j, j+1);
            end
        end
    end
end

function swap(arr, a, b)
    local temp = arr[a]
    arr[a] = arr[b];
    arr[b] = temp;
end