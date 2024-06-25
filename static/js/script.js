document.addEventListener('DOMContentLoaded', function () {
    // Sample data for demonstration
    const salesData = [10, 20, 30, 40, 50, 60, 70];
    const revenueData = [100, 200, 300, 400, 500, 600, 700];
    const totalSales = 1000;
    const totalTransactions = 50;
    const averageSale = totalSales / totalTransactions;
    const recentTransactions = [
        { date: '2024-06-01', productName: 'T-Shirt', quantity: 2, totalAmount: '$40.00' },
        { date: '2024-06-02', productName: 'Jeans', quantity: 1, totalAmount: '$50.00' },
    ];
    const lowStockAlerts = [
        { productName: 'Hoodie', stockLevel: 5 },
        { productName: 'Sneakers', stockLevel: 2 },
    ];

    // Update Key Metrics
    document.getElementById('totalSales').innerText = `$${totalSales.toFixed(2)}`;
    document.getElementById('totalTransactions').innerText = totalTransactions;
    document.getElementById('averageSale').innerText = `$${averageSale.toFixed(2)}`;

    // Update Recent Transactions List
    const recentTransactionsList = document.getElementById('recentTransactions');
    recentTransactions.forEach(transaction => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${transaction.date}</td>
            <td>${transaction.productName}</td>
            <td>${transaction.quantity}</td>
            <td>${transaction.totalAmount}</td>
        `;
        recentTransactionsList.appendChild(row);
    });

    // Update Low Stock Alerts
    const lowStockAlertsList = document.getElementById('lowStockAlerts');
    lowStockAlerts.forEach(alert => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${alert.productName}</td>
            <td>${alert.stockLevel}</td>
            <td><button class="btn btn-warning btn-sm">Reorder</button></td>
        `;
        lowStockAlertsList.appendChild(row);
    });

    // Sales Chart
    const salesCtx = document.getElementById('salesChart').getContext('2d');
    new Chart(salesCtx, {
        type: 'bar',
        data: {
            labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
            datasets: [{
                label: 'Sales',
                data: salesData,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

    // Revenue Chart
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'pie',
        data: {
            labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
            datasets: [{
                label: 'Revenue',
                data: revenueData,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                    'rgba(199, 199, 199, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)',
                    'rgba(199, 199, 199, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });


    const sidebarBtnMobile = document.getElementById('toggleSidebarMobile');
    const sidebarSticky = document.querySelector('.sidebar-sticky')
    sidebarSticky.style.width = '-150px'
    sidebarBtnMobile.addEventListener('click', () => {
        // alert('hey')
        if (sidebarSticky.style.left === '-150px') {
            sidebarSticky.style.left = '0'
        }
        else {
            sidebarSticky.style.left = '-150PX'
        }
    }
    )

    // Toggle Sidebar
    // document.getElementById('toggleSidebar').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('sidebar-collapsed');
    // });

    // // Toggle Mobile Sidebar
    // document.getElementById('toggleSidebarMobile').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('active');
    // });

    // Toggle Theme
    document.getElementById('themeToggle').addEventListener('click', function () {
        document.body.classList.toggle('dark-theme');
        document.body.classList.toggle('light-theme');
        this.innerText = document.body.classList.contains('dark-theme') ? 'Light Theme' : 'Dark Theme';
    });
});



document.addEventListener('DOMContentLoaded', function () {
    // Sample product data for demonstration
    const products = [
        { 
            id: 1, 
            name: 'T-Shirt', 
            sku: 'TS001', 
            price: 20.00, 
            stock: 50, 
            category: 'Clothing', 
            image: 'https://via.placeholder.com/50' 
        },
        { 
            id: 2, 
            name: 'Jeans', 
            sku: 'JN002', 
            price: 50.00, 
            stock: 30, 
            category: 'Clothing', 
            image: 'https://via.placeholder.com/50' 
        },
    ];

    // Function to render products in the table
    function renderProducts(products) {
        const productList = document.getElementById('productList');
        productList.innerHTML = '';
        products.forEach(product => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td><img src="${product.image}" alt="${product.name}" class="img-thumbnail" width="50"></td>
                <td>${product.name}</td>
                <td>${product.sku}</td>
                <td>$${product.price.toFixed(2)}</td>
                <td>${product.stock}</td>
                <td>${product.category}</td>
                <td>
                    <button class="btn btn-sm btn-warning edit-product" data-id="${product.id}">Edit</button>
                    <button class="btn btn-sm btn-danger delete-product" data-id="${product.id}">Delete</button>
                </td>
            `;
            productList.appendChild(row);
        });
    }

    // Initial render
    renderProducts(products);

    // Event listeners for search, filter, and sort
    document.getElementById('searchProducts').addEventListener('input', function () {
        const query = this.value.toLowerCase();
        const filteredProducts = products.filter(product => product.name.toLowerCase().includes(query));
        renderProducts(filteredProducts);
    });

    document.getElementById('filterCategory').addEventListener('change', function () {
        const category = this.value;
        const filteredProducts = category ? products.filter(product => product.category === category) : products;
        renderProducts(filteredProducts);
    });

    document.getElementById('sortProducts').addEventListener('change', function () {
        const sortBy = this.value;
        const sortedProducts = [...products].sort((a, b) => {
            if (sortBy === 'price') return a.price - b.price;
            if (sortBy === 'stock') return a.stock - b.stock;
            if (sortBy === 'category') return a.category.localeCompare(b.category);
            return 0;
        });
        renderProducts(sortedProducts);
    });

    // // Toggle Sidebar
    // document.getElementById('toggleSidebar').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('sidebar-collapsed');
    // });

    // // Toggle Mobile Sidebar
    // document.getElementById('toggleSidebarMobile').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('active');
    // });
    const sidebarBtnMobile = document.getElementById('toggleSidebarMobile');
    const sidebarSticky = document.querySelector('.sidebar-sticky')
    sidebarSticky.style.width = '-150px'
    sidebarBtnMobile.addEventListener('click', () => {
        // alert('hey')
        if (sidebarSticky.style.left === '-150px') {
            sidebarSticky.style.left = '0'
        }
        else {
            sidebarSticky.style.left = '-150PX'
        }
    }
    )

    // Toggle Theme
    document.getElementById('themeToggle').addEventListener('click', function () {
        document.body.classList.toggle('dark-theme');
        document.body.classList.toggle('light-theme');
        this.innerText = document.body.classList.contains('dark-theme') ? 'Light Theme' : 'Dark Theme';
    });
});

document.addEventListener('DOMContentLoaded', function () {
    // Sample product data for demonstration
    const products = [
        { id: 1, name: 'T-Shirt', price: 20.00, image: 'https://via.placeholder.com/50' },
        { id: 2, name: 'Jeans', price: 50.00, image: 'https://via.placeholder.com/50' },
        { id: 3, name: 'Jacket', price: 100.00, image: 'https://via.placeholder.com/50' },
        { id: 4, name: 'Sneakers', price: 70.00, image: 'https://via.placeholder.com/50' }
    ];

    const cart = [];

    // Function to render products in the catalog
    function renderProductCatalog(products) {
        const productCatalog = document.getElementById('productCatalog');
        productCatalog.innerHTML = '';
        products.forEach(product => {
            const item = document.createElement('div');
            item.className = 'product-item';
            item.innerHTML = `
                <img src="${product.image}" alt="${product.name}" width="50">
                <div class="product-details">
                    <h6>${product.name}</h6>
                    <p>$${product.price.toFixed(2)}</p>
                </div>
            `;
            item.addEventListener('click', () => addToCart(product));
            productCatalog.appendChild(item);
        });
    }

    // Function to render the cart summary
    function renderCart() {
        const cartSummary = document.getElementById('cartSummary');
        cartSummary.innerHTML = '';
        let totalPrice = 0;
        cart.forEach(item => {
            totalPrice += item.price * item.quantity;
            const cartItem = document.createElement('div');
            cartItem.className = 'cart-item';
            cartItem.innerHTML = `
                <img src="${item.image}" alt="${item.name}" width="50">
                <div class="item-details">
                    <span>${item.name} x${item.quantity}</span>
                    <span>$${(item.price * item.quantity).toFixed(2)}</span>
                </div>
                <button class="btn btn-sm btn-danger" onclick="removeFromCart(${item.id})">Remove</button>
            `;
            cartSummary.appendChild(cartItem);
        });
        document.getElementById('totalPrice').innerText = totalPrice.toFixed(2);
    }

    // Function to add products to the cart
    function addToCart(product) {
        const existingItem = cart.find(item => item.id === product.id);
        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            cart.push({ ...product, quantity: 1 });
        }
        renderCart();
    }

    // Function to remove products from the cart
    window.removeFromCart = function (id) {
        const index = cart.findIndex(item => item.id === id);
        if (index !== -1) {
            cart.splice(index, 1);
        }
        renderCart();
    }

    // Initial render of the product catalog
    renderProductCatalog(products);

    // Event listener for search
    document.getElementById('searchProducts').addEventListener('input', function () {
        const query = this.value.toLowerCase();
        const filteredProducts = products.filter(product => product.name.toLowerCase().includes(query));
        renderProductCatalog(filteredProducts);
    });

    // // Toggle Sidebar
    // document.getElementById('toggleSidebar').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('sidebar-collapsed');
    // });

    // // Toggle Mobile Sidebar
    // document.getElementById('toggleSidebarMobile').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('active');
    // });
    const sidebarBtnMobile = document.getElementById('toggleSidebarMobile');
    const sidebarSticky = document.querySelector('.sidebar-sticky')
    sidebarSticky.style.width = '-150px'
    sidebarBtnMobile.addEventListener('click', () => {
        // alert('hey')
        if (sidebarSticky.style.left === '-150px') {
            sidebarSticky.style.left = '0'
        }
        else {
            sidebarSticky.style.left = '-150PX'
        }
    }
    )

    // Toggle Theme
    document.getElementById('themeToggle').addEventListener('click', function () {
        document.body.classList.toggle('dark-theme');
        document.body.classList.toggle('light-theme');
        this.innerText = document.body.classList.contains('dark-theme') ? 'Light Theme' : 'Dark Theme';
    });

    // Complete Sale
    document.getElementById('completeSale').addEventListener('click', function () {
        alert('Sale Completed!');
        // Here you would add the logic to process the sale
        cart.length = 0;
        renderCart();
    });
});
document.addEventListener('DOMContentLoaded', function () {
    // Sample inventory data for demonstration
    const inventory = [
        { id: 1, name: 'T-Shirt', sku: 'TS001', price: 20.00, stock: 50, category: 'Clothing', supplier: 'ABC Supplies', reorderLevel: 10, image: 'https://via.placeholder.com/50' },
        { id: 2, name: 'Jeans', sku: 'JN002', price: 50.00, stock: 30, category: 'Clothing', supplier: 'XYZ Supplies', reorderLevel: 5, image: 'https://via.placeholder.com/50' },
    ];

    // Function to render inventory in the table
    function renderInventory(inventory) {
        const inventoryList = document.getElementById('inventoryList');
        inventoryList.innerHTML = '';
        inventory.forEach(item => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td><img src="${item.image}" alt="${item.name}" class="img-thumbnail" width="50"></td>
                <td>${item.name}</td>
                <td>${item.sku}</td>
                <td>$${item.price.toFixed(2)}</td>
                <td>${item.stock}</td>
                <td>${item.category}</td>
                <td>${item.supplier}</td>
                <td>${item.reorderLevel}</td>
                <td>
                    <button class="btn btn-sm btn-warning edit-inventory" data-id="${item.id}">Edit</button>
                    <button class="btn btn-sm btn-danger delete-inventory" data-id="${item.id}">Delete</button>
                </td>
            `;
            inventoryList.appendChild(row);
        });
    }

    // Initial render
    renderInventory(inventory);

    // Event listeners for search, filter, and sort
    document.getElementById('searchProducts').addEventListener('input', function () {
        const query = this.value.toLowerCase();
        const filteredInventory = inventory.filter(item => item.name.toLowerCase().includes(query));
        renderInventory(filteredInventory);
    });

    document.getElementById('filterCategory').addEventListener('change', function () {
        const category = this.value;
        const filteredInventory = category ? inventory.filter(item => item.category === category) : inventory;
        renderInventory(filteredInventory);
    });

    document.getElementById('sortProducts').addEventListener('change', function () {
        const sortBy = this.value;
        const sortedInventory = [...inventory].sort((a, b) => {
            if (sortBy === 'price') return a.price - b.price;
            if (sortBy === 'stock') return a.stock - b.stock;
            if (sortBy === 'category') return a.category.localeCompare(b.category);
            return 0;
        });
        renderInventory(sortedInventory);
    });

    // // Toggle Sidebar
    // document.getElementById('toggleSidebar').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('sidebar-collapsed');
    // });

    // // Toggle Mobile Sidebar
    // document.getElementById('toggleSidebarMobile').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('active');
    // });
    const sidebarBtnMobile = document.getElementById('toggleSidebarMobile');
    const sidebarSticky = document.querySelector('.sidebar-sticky')
    sidebarSticky.style.width = '-150px'
    sidebarBtnMobile.addEventListener('click', () => {
        // alert('hey')
        if (sidebarSticky.style.left === '-150px') {
            sidebarSticky.style.left = '0'
        }
        else {
            sidebarSticky.style.left = '-150PX'
        }
    }
    )

    // Toggle Theme
    document.getElementById('themeToggle').addEventListener('click', function () {
        document.body.classList.toggle('dark-theme');
        document.body.classList.toggle('light-theme');
        this.innerText = document.body.classList.contains('dark-theme') ? 'Light Theme' : 'Dark Theme';
    });
});

document.addEventListener('DOMContentLoaded', function () {
    // Sample data for demonstration
    const salesData = [10, 20, 30, 40, 50, 60, 70];
    const revenueData = [100, 200, 300, 400, 500, 600, 700];
    const topSellingProducts = [
        { name: 'T-Shirt', unitsSold: 50, totalSales: 1000 },
        { name: 'Jeans', unitsSold: 30, totalSales: 1500 },
    ];
    const salesByCategory = [
        { category: 'Clothing', unitsSold: 80, totalSales: 2500 },
        { category: 'Footwear', unitsSold: 20, totalSales: 1000 },
    ];
    const userPerformance = [
        { user: 'Alice', sales: 30, totalSales: 1500 },
        { user: 'Bob', sales: 70, totalSales: 3000 },
    ];

    // Update tables
    function updateTable(id, data, columns) {
        const tableBody = document.getElementById(id);
        tableBody.innerHTML = '';
        data.forEach(row => {
            const tr = document.createElement('tr');
            columns.forEach(col => {
                const td = document.createElement('td');
                td.textContent = row[col];
                tr.appendChild(td);
            });
            tableBody.appendChild(tr);
        });
    }

    updateTable('topSellingProducts', topSellingProducts, ['name', 'unitsSold', 'totalSales']);
    updateTable('salesByCategory', salesByCategory, ['category', 'unitsSold', 'totalSales']);
    updateTable('userPerformance', userPerformance, ['user', 'sales', 'totalSales']);

    // Sales Bar Chart
    const salesBarChart = document.getElementById('salesBarChart').getContext('2d');
    new Chart(salesBarChart, {
        type: 'bar',
        data: {
            labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
            datasets: [{
                label: 'Sales',
                data: salesData,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

    // Sales Pie Chart
    const salesPieChart = document.getElementById('salesPieChart').getContext('2d');
    new Chart(salesPieChart, {
        type: 'pie',
        data: {
            labels: ['Clothing', 'Footwear', 'Accessories'],
            datasets: [{
                label: 'Revenue',
                data: revenueData,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });

    // // Toggle Sidebar
    // document.getElementById('toggleSidebar').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('sidebar-collapsed');
    // });

    // // Toggle Mobile Sidebar
    // document.getElementById('toggleSidebarMobile').addEventListener('click', function () {
    //     document.querySelector('.sidebar').classList.toggle('active');
    // });
    const sidebarBtnMobile = document.getElementById('toggleSidebarMobile');
    const sidebarSticky = document.querySelector('.sidebar-sticky')
    sidebarSticky.style.width = '-150px'
    sidebarBtnMobile.addEventListener('click', () => {
        // alert('hey')
        if (sidebarSticky.style.left === '-150px') {
            sidebarSticky.style.left = '0'
        }
        else {
            sidebarSticky.style.left = '-150PX'
        }
    }
    )

    // Toggle Theme
    document.getElementById('themeToggle').addEventListener('click', function () {
        document.body.classList.toggle('dark-theme');
        document.body.classList.toggle('light-theme');
        this.innerText = document.body.classList.contains('dark-theme') ? 'Light Theme' : 'Dark Theme';
    });

    // Filter Reports
    document.getElementById('filterReports').addEventListener('click', function () {
        const startDate = document.getElementById('startDate').value;
        const endDate = document.getElementById('endDate').value;
        alert(`Filtering reports from ${startDate} to ${endDate}`);
        // Here you would add the logic to filter the data based on the selected date range
    });

    // Export PDF and CSV
    document.getElementById('exportPDF').addEventListener('click', function () {
        alert('Exporting to PDF');
        // Here you would add the logic to export the data to PDF
    });

    document.getElementById('exportCSV').addEventListener('click', function () {
        alert('Exporting to CSV');
        // Here you would add the logic to export the data to CSV
    });
});



