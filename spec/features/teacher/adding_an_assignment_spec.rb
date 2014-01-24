require 'spec_helper'

feature 'teacher adding an assignment' do
  
  scenario 'by navigating to new assignment page' do
    teacher = create(:user)
    visit teacher_dashboard_path(as: teacher)
    click_link I18n.t('helpers.new_model', model: 'Assignment')
    expect(current_path).to eq(new_teacher_assignment_path)
  end

  scenario 'can create an assignment with valid attributes' do

    teacher = create(:user)

    %w(Math Science History Quantum\ Physics).each do |course_name|
      create(:course, name: course_name, teacher: teacher)
    end

    visit new_teacher_assignment_path(as: teacher)

    assigned_on = DateTime.parse('January 15, 2014')
    due_on = DateTime.parse('January 17, 2014')

    within_form(:assignment) do |f|
      f.select_from_dropdown(:course_id, 'Science')
      f.fill_in_text_field(:name, 'Pop Quiz')
      f.fill_in_text_field(:description, 'I hope you studied!')
      f.select_date(:assigned_on, assigned_on )
      f.select_date(:due_on, due_on )
      f.fill_in_text_field(:points_possible, 100)
    end
      click_button I18n.t('helpers.submit.create', model: 'Assignment')

    expect(current_path).to eq(teacher_assignments_path)
    expect(page).to have_content('course: Science')
    expect(page).to have_content('name: Pop Quiz')
    expect(page).to have_content('description: I hope you studied!')
    expect(page).to have_content('assigned on: January 15, 2014')
    expect(page).to have_content('due on: January 17, 2014')
    expect(page).to have_content('points possible: 100')
  end

  def within_form(form_prefix, &block)
    completion_helper = FormCompletionHelper.new(form_prefix, self)
    yield completion_helper
  end
end

class FormCompletionHelper

  delegate :select, :fill_in, :click_button, to: :context

  def initialize(prefix, context)
    @prefix = prefix
    @context = context
  end

  def fill_in_text_field(field, value)
    fill_in :"#{prefix}_#{field}", with: value  
  end

  def select_date(field, date)
    select date.year, from: :"#{prefix}_#{field}_1i"
    select date.strftime('%B'), from: :"#{prefix}_#{field}_2i"
    select date.day, from: :"#{prefix}_#{field}_3i"
  end

  def select_from_dropdown(field, value)
    select value, from: :"#{prefix}_#{field}"
  end

  private

  attr_reader :prefix, :context

end
