


document.addEventListener('DOMContentLoaded', () => {
    const themeSwitcher = document.getElementById('theme-switcher');
    const body = document.body;
    const currentTheme = localStorage.getItem('theme');
    if (currentTheme) {
        body.classList.add(currentTheme);
    }

    themeSwitcher.addEventListener('click', () => {
        if (body.classList.contains('dark-theme')) {
            console.log("Hellow world from script.js!");
            body.classList.remove('dark-theme');
            localStorage.setItem('theme', 'light-theme');
        } else {
            body.classList.add('dark-theme');
            localStorage.setItem('theme', 'dark-theme');
        }
    });
});