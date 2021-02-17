class CreateView < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
        CREATE OR REPLACE VIEW public.view_articles
        AS
        SELECT a.article_number,
           a.name,
           a.category,
           a.price,
           c.default_price,
           c.name AS category_name,
           c.points
          FROM articles a
            JOIN categories c ON c.category = a.category;
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP VIEW IF EXISTS public.view_articles;
        SQL
      end
    end
  end
end
