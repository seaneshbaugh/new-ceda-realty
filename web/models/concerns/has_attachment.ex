defmodule CedaRealty.Concerns.HasAttachment do
  defmodule ImageProcessor do
    def process!(name, callback, path) do
      path_parts = String.split(path, ".")

      style_path = Enum.join(Enum.take(path_parts, length(path_parts) - 1), ".") <> "_" <> Atom.to_string(name) <> "." <> List.last(path_parts)

      Mogrify.open(path)
      |> Mogrify.copy
      |> (callback).()
      |> Mogrify.save(style_path)
    end
  end

  defmacro __using__(options) do
    if is_atom(options) do
      attachment_name = options

      styles = []

      processor = ImageProcessor
    else
      attachment_name = options[:name] || :file

      styles = options[:styles] || []

      processor = options[:processor] || ImageProcessor
    end

    singular_attachment_name = Atom.to_string(attachment_name) |> String.downcase

    plural_attachment_name = Inflex.pluralize(singular_attachment_name)

    singular_module_name = Module.split(__CALLER__.module) |> List.last |> String.downcase

    plural_module_name = Inflex.pluralize(singular_module_name)


    quote do
      import unquote(__MODULE__)

      def unquote(:"#{singular_attachment_name}")(model) do
        %{
          path: Map.get(model, unquote(:"#{singular_attachment_name}_path")),
          file_size: Map.get(model, unquote(:"#{singular_attachment_name}_file_size")),
          file_content_type: Map.get(model, unquote(:"#{singular_attachment_name}_file_content_type")),
          original_file_name: Map.get(model, unquote(:"#{singular_attachment_name}_original_file_name")),
          checksum: Map.get(model, unquote(:"#{singular_attachment_name}_checksum"))
        }
      end

      def unquote(:"save_#{singular_attachment_name}!")(model, %{unquote("#{singular_attachment_name}") => %{path: temp_path}}) do
        path = apply(__MODULE__, unquote(:"#{singular_attachment_name}_path"), [model])

        if path do
          File.mkdir_p!(unquote({:"#{plural_attachment_name}_path", [], []}))

          File.cp!(temp_path, path)

          unquote(styles) |> Enum.each fn {name, callback} ->
            apply(unquote(processor), :process!, [name, callback, path])
          end
        end
      end

      def unquote(:"save_#{singular_attachment_name}!")(_changeset, _params) do
      end

      def unquote(:"delete_#{singular_attachment_name}!")(%Ecto.Changeset{changes: _changes, model: model}) do
        path = apply(__MODULE__, unquote(:"#{singular_attachment_name}_path"), [model])

        if path do
          File.rm!(path)
        end
      end

      def unquote(:"delete_#{singular_attachment_name}!")(model) do
        path = apply(__MODULE__, unquote(:"#{singular_attachment_name}_path"), [model])

        if path do
          File.rm!(path)
        end
      end

      def unquote(:"replace_#{singular_attachment_name}!")(model, %{unquote("#{singular_attachment_name}") => %{path: _temp_path}} = params) do
        apply(__MODULE__, unquote(:"delete_#{singular_attachment_name}!"), [model])

        apply(__MODULE__, unquote(:"save_#{singular_attachment_name}!"), [model, params])
      end

      def unquote(:"replace_#{singular_attachment_name}!")(model, params) do
      end

      def unquote(:"#{plural_attachment_name}_path")() do
        Path.expand(unquote("./priv/static/system/#{plural_module_name}/#{plural_attachment_name}"))
      end

      def unquote(:"#{singular_attachment_name}_path")(%Ecto.Changeset{changes: _changes, model: _model} = changeset) do
        path = Ecto.Changeset.get_field(changeset, unquote(:"#{singular_attachment_name}_path"))

        case path do
          nil -> nil
          _ -> Path.join(unquote({:"#{plural_attachment_name}_path", [], []}), path)
        end
      end

      def unquote(:"#{singular_attachment_name}_path")(%{unquote(:"#{singular_attachment_name}_path") => nil}) do
        nil
      end

      def unquote(:"#{singular_attachment_name}_path")(%{unquote(:"#{singular_attachment_name}_path") => ""}) do
        nil
      end

      def unquote(:"#{singular_attachment_name}_path")(%{unquote(:"#{singular_attachment_name}_path") => path}) do
        Path.join(unquote({:"#{plural_attachment_name}_path", [], []}), path)
      end

      def unquote(:"#{singular_attachment_name}_path")(_) do
        nil
      end

      def unquote(:"set_#{singular_attachment_name}_attributes")(changeset, :empty) do
        changeset
      end

      def unquote(:"set_#{singular_attachment_name}_attributes")(changeset, %{unquote(singular_attachment_name) => attachment}) do
        file_size = File.stat!(attachment.path).size

        file_checksum = :crypto.hash(:sha512, File.read!(attachment.path)) |> Base.encode16 |> String.downcase

        if Regex.match?(~r/\.tar\.gz\z/i, attachment.filename) do
          file_extension = ".tar.gz"
        else
          file_extension = Path.extname(attachment.filename)
          |> String.downcase
          |> String.replace(~r/\.jpeg\z/, ".jpg")
          |> String.replace(~r/\.mpg\z/, ".mpeg")
          |> String.replace(~r/\.tif\z/, ".tiff")
          |> String.replace(~r/\.markdown\z/, ".md")
        end

        file_path = file_checksum <> file_extension

        changeset
        |> Ecto.Changeset.put_change(unquote(:"#{singular_attachment_name}_path"), file_path)
        |> Ecto.Changeset.put_change(unquote(:"#{singular_attachment_name}_file_size"), file_size)
        |> Ecto.Changeset.put_change(unquote(:"#{singular_attachment_name}_file_content_type"), attachment.content_type)
        |> Ecto.Changeset.put_change(unquote(:"#{singular_attachment_name}_original_file_name"), attachment.filename)
        |> Ecto.Changeset.put_change(unquote(:"#{singular_attachment_name}_checksum"), file_checksum)
      end

      def unquote(:"set_#{singular_attachment_name}_attributes")(changeset, _params) do
        changeset
      end
    end
  end
end
