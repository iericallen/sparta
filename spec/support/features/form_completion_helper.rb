module Features
  class FormCompletionHelper

    delegate :select, :fill_in, :click_button, to: :context

    def initialize(prefix, context)
      @prefix = prefix
      @context = context
    end

    def fill_in_text_field(options)
      options.each do |field, value|
        fill_in :"#{prefix}_#{field}", with: value
      end
    end
    alias :fill_in_text_fields :fill_in_text_field

    def select_date(options)
      options.each do |field, date|
        select date.year, from: :"#{prefix}_#{field}_1i"
        select date.strftime('%B'), from: :"#{prefix}_#{field}_2i"
        select date.day, from: :"#{prefix}_#{field}_3i"
      end
    end
    alias :select_dates :select_date

    def select_from_dropdown(options)
      options.each do |field, value|
        select value, from: :"#{prefix}_#{field}"
      end
    end
    alias :select_from_dropdowns :select_from_dropdown

    def submit(translation_key)
      click_button I18n.t("helpers.submit.#{translation_key}", model: model_name)
    end

    private

    attr_reader :prefix, :context

    def model_name
      prefix.to_s.capitalize
    end
  end
end
