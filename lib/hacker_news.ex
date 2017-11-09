defmodule HackerNews do
  def client_spec do
    headers = []
    SlowScraper.client_spec(:hn, headers, HackerNews.HTTP)
  end

  def get_newest_page do
    SlowScraper.request_page(:hn, "https://www.linio.com.mx/search?q=apple", 10_000, 100, 0)
       |> parse_news()
  end

  def parse_news(hn_page) do
    Floki.find(hn_page, ".catalogue-product-sm-container")
      |> Enum.map(fn  new_item ->
        link = Floki.find(new_item, ".catalogue-product")
        title = Floki.text(link)
        href = Floki.attribute(link, "href") |> List.first()
        %{
          title: title,
          url: href,
        }
      end)
  end

  defmodule HTTP do
    require Logger
    @behaviour SlowScraper.Adapter
    def scrape(headers, url) do
      Logger.info("Requesting #{url}")
       {:ok, response} = HTTPoison.get(url, headers, [])
       body = Map.get(response, :body)
       result = Floki.find(body, ".wrapper.container-fluid")
       result
    end
  end
end
