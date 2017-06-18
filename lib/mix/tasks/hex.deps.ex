defmodule Mix.Tasks.Hex.Deps do

  use Mix.Task

  @shortdoc "Print package info with deps_style"

  def run(args) do

    Hex.start

    args
    |> process
    |> print
  end


  defp process(args), do: process(args, [])
  defp process([], acc), do: acc
  defp process([package_name | tail], acc) do
    package = Hex.API.Package.get(package_name)
    |> process_hex_response(package_name)

    process(tail, [package | acc])
  end

  defp process_hex_response({:ok, {404, _response, _headers}}, package_name) do
    Mix.raise "#{package_name} not found"
  end
  defp process_hex_response({:ok, {200, %{"name" => name, "releases" => releases}, _headers}}, _package_name) do
    latest_version = List.first(releases) |> Map.get("version")
    %{name: name, version: latest_version}
  end

  defp print(packages) do
    deps_string = packages
    |> Enum.map(fn e ->
      %{name: name, version: version} = e
      inspect {String.to_atom(name), "~> #{version}"}
    end)
    |> Enum.join(",\n")

    Mix.shell.info deps_string
  end

end
