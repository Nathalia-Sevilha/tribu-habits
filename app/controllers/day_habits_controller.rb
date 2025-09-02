class DayHabitsController < ApplicationController
  def mark_as_done;end
    # Nathalia
  def update
    @day_habit = DayHabit.find(params[:id])
    @day_habit.update(day_habit_params)

    day = @day_habit.day
    user = @day_habit.habit.user
    completed_count = day.completed_habits_count(user)
    total_count = day.total_habits_count(user)
    percent = day.completion_percentage(user)

    render json: {
      completed_count: completed_count,
      total_count: total_count,
      percent: percent
    }
  end

  private

  def day_habit_params
    params.require(:day_habit).permit(:done)
  end
  # Nathalia
end
