defmodule Smash.Server do
  use GenServer

  def start_link(args, opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  def client do
    love = System.find_executable("love") 
    Port.open({:spawn_executable, love}, [args: ["../", "client"]])
  end

  def init([]) do
    {:ok, sockr} = :gen_udp.open(12345, [:binary])
    {:ok, %{sock: sockr, world: %{}}}
  end

  def terminate(_, %{sock: sock}) do
    :gen_udp.close(sock)
  end

  def handle_info({:udp, _port, client_ip, port, msg}, state) do
    [entity, cmd | parms] = String.split(msg)
    state = case cmd do
      "move" ->
        [x_str, y_str] = parms
        {{x, ""}, {y, ""}} = {Float.parse(x_str), Float.parse(y_str)}
        ent = state.world[entity] || %{x: x, y: y}
        %{state | world: Map.put(state.world, entity, %{ent | x: ent.x + x, y: ent.y + y})}
      "at" ->
        [x_str, y_str] = parms
        {{x, ""}, {y, ""}} = {Float.parse(x_str), Float.parse(y_str)}
        %{state | world: Map.put(state.world, entity, %{x: x, y: y})}
      "update" ->
        for {k, %{x: x, y: y}} <- state.world do
          :gen_udp.send(state.sock, client_ip, port, "#{k} at #{x} #{y}")
        end
        state
      "quit" ->
        nil
    end

    if state do
      {:noreply, state}
    else
      {:stop, :normal, state}
    end
  end
end
