defmodule Askbywho.Locale do
  import Plug.Conn

  def init(_opts), do: nil

  def call(conn, _opts) do
    # These languages assign a locale automatically
    langs = %{"en" => "en", "en-us" => "en", "fi" => "fi",
    "fi-fi" => "fi"}

    # TODO add when portuguese translation is ready
    # "pt-br" => "pt-BR", "pt" => "pt-BR"

    # fetching browser's guess of what languages the user prefers
    case get_req_header(conn, "accept-language") do
      [language] ->
        pattern  = :binary.compile_pattern([",", ";"])
        IO.puts("accept-language is #{language}")
        choose_locale(conn, String.split(language, pattern), langs)
    end

    # Test different language versions with URL, for example beta.askbywho.com/?locale=fi
    case conn.params["locale"] || get_session(conn, :locale) do
      nil     -> conn
      locale  ->
        Gettext.put_locale(Askbywho.Gettext, locale)
        conn |> put_session(:locale, locale)
    end
  end

  defp choose_locale(conn, [head | tail], langs) do
    # Parse accept-language from browser and see if they match our language version
    case Map.fetch(langs, String.downcase(head)) do
      {:ok, l}  ->
        Gettext.put_locale(Askbywho.Gettext, l)
        conn |> put_session(:locale, l)
        IO.puts("locale set as #{l}")
      :error  ->
        case tail do
          [] -> conn
          _ -> choose_locale(conn, tail, langs)
        end
    end
  end
end