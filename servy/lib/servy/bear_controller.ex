defmodule Servy.BearController do
  alias Servy.Bear
  alias Servy.Conv
  alias Servy.Wildthings

  @templates_path Path.expand("templates", File.cwd!)

  def index(%Conv{} = conv, _) do
    bears =
      Wildthings.list_bears
      |> Enum.sort(&Bear.order_by_name_asc/2)

    render(conv, "index.eex", bears: bears)
  end

  def show(%Conv{} = conv, %{"id" => id}) do
    case Wildthings.get_bear(id) do
      nil -> %{conv | body: "No bear with id #{id} found", status: 404}
      bear -> render(conv, "show.eex", bear: bear)
    end
  end

  def delete(%Conv{} = conv, _) do
    %{conv | body: "Deleting a bear is forbidden!", status: 403}
  end

  defp render(%Conv{} = conv, template, bindings \\ []) do
    body =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %{conv | body: body}
  end
end
