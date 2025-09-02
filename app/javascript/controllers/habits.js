document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll(".habit-checkbox").forEach(function(checkbox) {
    checkbox.addEventListener("change", function() {
      const dayHabitId = this.dataset.id;
      const done = this.checked;

      fetch(`/day_habits/${dayHabitId}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ day_habit: { done: done } })
      })
      .then(response => response.json())
      .then(data => {

        const progressBar = document.getElementById("progress-bar");
        progressBar.style.width = data.percent + "%";

        const progressText = document.getElementById("progress-text");
        const remainingText = document.getElementById("remaining-text");

        progressText.innerHTML = `You have completed ${data.completed_count} out of ${data.total_count} habits.`;

        if (data.completed_count < data.total_count) {
          remainingText.textContent = `${data.total_count - data.completed_count} to go!`;
        } else {
          remainingText.textContent = "All habits completed! 🎉";
        }
      });
    });
  });
});
