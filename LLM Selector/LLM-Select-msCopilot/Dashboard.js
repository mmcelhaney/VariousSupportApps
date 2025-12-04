const categorySelect = document.getElementById('category');
const platformSelect = document.getElementById('platform');
const resultsDiv = document.getElementById('results');

const categories = [
  "Create Images", "Create Videos", "Mixed Scenarios", "Voice/Audio",
  "Productivity", "Coding", "Automation", "Employment", "Browsers"
];
const platforms = ["Web", "Windows", "macOS", "Linux", "Mobile", "Browser Extension"];

categories.forEach(c => categorySelect.innerHTML += `<option>${c}</option>`);
platforms.forEach(p => platformSelect.innerHTML += `<option>${p}</option>`);

function suggest() {
  const category = categorySelect.value;
  const platform = platformSelect.value;
  const task = document.getElementById('task').value.toLowerCase();
  resultsDiv.innerHTML = '';

  const filtered = tools.filter(t =>
    t.category === category &&
    t.platform.includes(platform) &&
    t.use_cases.toLowerCase().includes(task)
  );

  filtered.slice(0, 10).forEach(t => {
    resultsDiv.innerHTML += `
      <div class="tool">
        <img src="icons/${t.id}.png" class="logo" />
        <a href="${t.signup_url}" target="_blank"><strong>${t.name}</strong></a><br/>
        <em>${t.best_for}</em><br/>
        ${t.strengths}<br/>
        <strong>Pricing:</strong> ${t.pricing}
      </div>
    `;
  });

  localStorage.setItem('lastCategory', category);
  localStorage.setItem('lastPlatform', platform);
  localStorage.setItem('lastTask', task);
}

function exportCSV() {
  const rows = [["Name", "Category", "Platform", "Best For", "Pricing", "Signup URL"]];
  tools.forEach(t => {
    rows.push([t.name, t.category, t.platform.join(','), t.best_for, t.pricing, t.signup_url]);
  });
  const csv = rows.map(r => r.join(",")).join("\n");
  const blob = new Blob([csv], { type: 'text/csv' });
  const link = document.createElement('a');
  link.href = URL.createObjectURL(blob);
  link.download = "ai_tools.csv";
  link.click();
}

// Restore filters
window.onload = () => {
  categorySelect.value = localStorage.getItem('lastCategory') || categories[0];
  platformSelect.value = localStorage.getItem('lastPlatform') || platforms[0];
  document.getElementById('task').value = localStorage.getItem('lastTask') || '';
};