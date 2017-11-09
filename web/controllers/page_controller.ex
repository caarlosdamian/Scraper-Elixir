defmodule Hackerpage.PageController do
  use Hackerpage.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
