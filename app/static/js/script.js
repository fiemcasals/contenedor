function toggleMenu() {
    const menu = document.getElementById('menu');
    // Cambiar la visibilidad del menú
    if (menu.style.display === "none" || menu.style.display === "") {
        menu.style.display = "block";  // Mostrar el menú
    } else {
        menu.style.display = "none";  // Ocultar el menú
    }
}
