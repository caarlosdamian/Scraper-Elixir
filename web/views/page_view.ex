defmodule Hackerpage.PageView do
  use Hackerpage.Web, :view

  def  hn_commers do
    HackerNews.get_newest_page()


  end
end
