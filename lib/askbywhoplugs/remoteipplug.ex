defmodule Askbywhoplugs.RemoteIPPlug do
  @behaviour Plug
  import Plug.Conn

  def init([]), do: []

  def call(conn, []) do
    case get_req_header(conn, "x-real-ip") do
      [] -> conn
      [real_ip] ->
        case :inet_parse.address(to_char_list(real_ip)) do
          {:ok, real_ip} -> %{conn | remote_ip: real_ip}
          _ -> conn
        end
    end
  end
end
