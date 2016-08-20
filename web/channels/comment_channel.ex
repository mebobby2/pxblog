defmodule Pxblog.CommentChannel do
  use Pxblog.Web, :channel

  def join("comments:" <> _comment_id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("CREATED_COMMENT", payload, socket) do
    broadcast socket, "CREATED_COMMENT", payload
    {:noreply, socket}
  end

  def handle_in("APPROVED_COMMENT", payload, socket) do
    broadcast socket, "APPROVED_COMMENT", payload
    {:noreply, socket}
  end

  def handle_in("DELETED_COMMENT", payload, socket) do
    broadcast socket, "DELETED_COMMENT", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
