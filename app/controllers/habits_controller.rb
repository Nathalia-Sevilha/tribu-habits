class HabitsController < ApplicationController
  def index
    @habits = policy_scope(Habit)
  end

  def show
    authorize @habit
  end

  def new;end
  def create;end
  def edit;end
  def update;end
  def destroy;end
end
