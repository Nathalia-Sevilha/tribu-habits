class HabitsController < ApplicationController
  before_action :set_habit, only: [ :show, :edit, :update, :destroy ]

  def index
    @habits = policy_scope(Habit)
  end

  def show
    authorize @habit
  end

  def new
    @habit = Habit.new
    authorize @habit
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.user = current_user
    @habit.community = Community.find_by(title: @habit.title)
    authorize @habit
    if @habit.save
      redirect_to @habit, notice: "Habit was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  authorize @habit
  end

  def update
    if @habit.update(habit_params)
      authorize @habit
      redirect_to @habit, notice: "Habit was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit.destroy
    authorize @habit
    redirect_to habits_path, notice: "Habit was successfully deleted.", status: :see_other
  end

  def preselect
    authorize Habit
    @habits = Habit.all
  end

  private

  def set_habit
    @habit = Habit.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:title, :description, :streak, :color, day_ids: [])
  end
end
