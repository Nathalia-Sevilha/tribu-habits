class HabitsController < ApplicationController
  before_action :set_habit, only: [ :show, :edit, :update, :destroy ]

  def index
    today_name = params[:day] || Date::DAYNAMES[Date.today.wday] # the day clicked or today
    @day = Day.find_by(name: today_name)
    @habits = policy_scope(Habit).joins(:days).where(days: { name: today_name })
  end

  def show
    authorize @habit
  end

  def new
    if params[:habit_id].present?
      @habit_title = Habit.find(params[:habit_id]).title
      @habit_community = Habit.find(params[:habit_id]).community.title
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
      @habit.community = Community.find(8)
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

  private

  def set_habit
    @habit = Habit.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:title, :description, :streak, :color, day_ids: [])
  end
end
