defmodule WeMeApiWeb.BeamChannel do
  use WeMeApiWeb, :channel

  def join(_beam, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (beam:connectionId).
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_in("register", payload, socket) do
    broadcast(socket, "register", payload)
    {:noreply, socket}
  end

  def handle_in("disconnect", payload, socket) do
    broadcast(socket, "disconnect", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
