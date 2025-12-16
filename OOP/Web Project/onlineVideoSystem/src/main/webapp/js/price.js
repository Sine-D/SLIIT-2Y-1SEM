// Simple interaction for pricing buttons
document.querySelectorAll('.btn-select').forEach(button => {
    button.addEventListener('click', () => {
        const plan = button.closest('.card').querySelector('.card-title').textContent;
        alert(`You selected the ${plan} plan. Thank you!`);
    });
});
