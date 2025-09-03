class HabitsController < ApplicationController
  before_action :set_habit, only: [ :show, :edit, :update, :destroy ]

  def index
    today_name = params[:day] || Date::DAYNAMES[Date.today.wday]
    @day = Day.find_by(name: today_name)
    @habits = policy_scope(Habit).joins(:days).where(days: { name: today_name }).order(created_at: :desc)
    @total_count = @habits.count
    @completed_count = DayHabit.where(habit_id: @habits.pluck(:id), day_id: @day.id, done: true).count
    @completion_percentage = @total_count > 0 ? ((@completed_count.to_f / @total_count) * 100).round : 0
  end

  def show
    authorize @habit
  end

  def new
    if params[:habit_id].present?
      @habit_title = List.find(params[:habit_id]).title
      @habit_community = List.find(params[:habit_id]).community.title
      @habit = Habit.new
      @habit.title = @habit_title
      authorize @habit
    else
      @habit = Habit.new
      authorize @habit
    end
  end

  def create
    @habit = Habit.new(habit_params)
    unless List.where(title: @habit.title).empty?
      @list = List.where(title: @habit.title).first
      @habit.community = Community.find(@list.community_id)
    else
      @habit.community = Community.last
    end
    @habit.user = current_user
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
    authorize @habit
    @habit.destroy
    redirect_to habits_path, notice: "Habit was successfully deleted.", status: :see_other
  end

  def preselect
    authorize Habit
    @lists = List.all
  end

  def toggle_done
    authorize Habit
    habit = Habit.find(params[:habit_id])
    day = Day.find(params[:day_id])

    day_habit = DayHabit.find_or_initialize_by(habit: habit, day: day)
    day_habit.done = !day_habit.done
    if day_habit.done
      habit.increment(:streak)
    else
      habit.decrement(:streak) if habit.streak > 0
    end
    habit.save!
    day_habit.save!

    # @day = day
    # @habits = policy_scope(Habit).joins(:days).where(days: { name: day.name })
    # @total_count = @habits.count
    # @completed_count = DayHabit.where(habit_id: @habits.pluck(:id), day_id: @day.id, done: true).count
    # @completion_percentage = @total_count > 0 ? ((@completed_count.to_f / @total_count) * 100).round : 0

    # render :index, status: :ok

    redirect_to habits_path(day: day.name), notice: "Habit status updated."
  end

  private

  def set_habit
    @habit = Habit.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:title, :description, :streak, :color, day_ids: [])
  end
end
