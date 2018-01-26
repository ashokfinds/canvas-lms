#
# Copyright (C) 2018 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

require_relative '../../helpers/gradezilla_common'
require_relative '../pages/gradezilla_page'
require_relative '../pages/gradezilla_cells_page'

describe "Gradezilla" do
  include_context "in-process server selenium tests"
  include GradezillaCommon

  describe 'complete/incomplete assignment grading' do
    before :once do
      init_course_with_students 1
      @assignment = @course.assignments.create!(grading_type: 'pass_fail', points_possible: 10)
      @assignment.grade_student(@students[0], grade: 'pass', grader: @teacher)
    end

    before :each do
      user_session(@teacher)
      Gradezilla.visit(@course)
    end

    it 'is maintained in editable mode', priority: "1", test_id: 3426618 do
      skip('This is skeleton code that acts as AC for GRADE-76 which is WIP')
      Gradezilla::Cells.grading_cell(@students[0], @assignment).click
      expect(Gradezilla::Cells.grade_cell_input(@students[0], @assignment)).to include_text('Complete')
    end

    it 'is maintained on page refresh post grade update', priority: "1", test_id: 3435317 do
      skip('This is skeleton code that acts as AC for GRADE-76 which is WIP')
      Gradezilla::Cells.edit_grade(@students[0], @assignment, "fail")
      refresh_page
      expect(Gradezilla::Cells.get_grade(@students[0], @assignment)).to include_text('Incomplete')
    end
  end
end