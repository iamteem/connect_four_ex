defmodule ConnectFourWeb.MaterialInputHelpers do
  defmacro __using__(_) do
    Enum.map [:text_input, :password_input, :email_input], fn(type) ->
      quote do
        def unquote(:"mat_#{type}")(form, field, opts \\ []) do
          new_opts = ConnectFourWeb.MaterialInputHelpers.merge_material_class(form, field, opts)
          apply(Phoenix.HTML.Form, unquote(type), [form, field, new_opts])
        end
      end
    end
  end

  def merge_material_class(form, field, opts) do
    func = fn (current_class) ->
      current_class = current_class || ""
      new_class =
        if form.errors[field] do
          "validate invalid " <> current_class
        else
          "validate " <> current_class
        end

      {current_class, new_class}
    end
    {_, new_opts} = Keyword.get_and_update(opts, :class, func)
    new_opts
  end
end
