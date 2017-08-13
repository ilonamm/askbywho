defmodule Askbywho.Locale do
  import Plug.Conn


  def init(opts), do: nil

  def call(conn, _opts) do
    langs = %{"en" => "en", "en-us" => "en", "fi" => "fi", "fi-FI" => "fi",
    "fi-fi" => "fi", "pt-BR" => "pt-BR", "pt-br" => "pt-BR", "pt" => "pt-BR"}


    case get_req_header(conn, "accept-language") do
      [language] ->
        pattern  = :binary.compile_pattern([",", ";"])
        split_string = String.split(language, pattern)
        choose_locale(conn, split_string, langs)
    end


    case conn.params["locale"] || get_session(conn, :locale) do
      nil     -> conn
      locale  ->
        Gettext.put_locale(Askbywho.Gettext, locale)
        conn |> put_session(:locale, locale)
    end

  end

  defp choose_locale(conn, [head | tail], langs) do
    case Map.fetch(langs, head) do
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
