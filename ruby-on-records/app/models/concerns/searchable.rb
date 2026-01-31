# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  class_methods do
    # Búsqueda genérica en múltiples campos
    # @param query [String] término de búsqueda
    # @param fields [Array<Symbol>] campos donde buscar
    # @return [ActiveRecord::Relation]
    def search_in_fields(query, fields)
      return all if query.blank?

      sanitized_query = sanitize_sql_like(query.to_s.strip)
      adapter = connection.adapter_name.downcase
      op = adapter.include?("postgres") ? "ILIKE" : "LIKE"

      conditions = fields.map { |field| "#{field} #{op} :q" }.join(" OR ")
      where(conditions, q: "%#{sanitized_query}%")
    end
  end
end
