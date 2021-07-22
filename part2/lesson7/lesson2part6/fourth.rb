# frozen_string_literal: true

str = 'Возьмите текст этого задания и извлеките из него все слова, '\
      'которые начинаются с символа \'и\'. Сформируйте из них список '\
      'уникальных слов и выведите их в порядке увеличения количества символов в слове.'
arr = str.split.map { |s| s.gsub(/[,.']/, '') }.select { |s| s.start_with?('и') }
p arr.uniq.sort_by(&:size)
